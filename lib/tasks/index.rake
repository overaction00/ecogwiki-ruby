namespace :index do

  require 'set'
  require 'trie'
  require 'redcarpet'

  def peel_markdown(markdown, page)
    markup = markdown.render(page.body).html_safe
    ActionView::Base.full_sanitizer.sanitize(markup)
  end

  task :generate => :environment do

    options = {
        :autolink => true,
        :space_after_headers => true,
        :no_intra_emphasis => true,
        :fenced_code_blocks => true,
        :disable_indented_code_blocks => true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)

    # term frequency 를 계산한다.
    tf = {}
    word_set = Set.new
    Wikipage.all.each do |page|
      next if page.body.blank?

      only_text = peel_markdown(markdown, page)

      tf[page.title] = tf.has_key?(page.title) ? tf[page.title] : {}
      doc_body = tf[page.title]
      only_text.split.each do |word|
        (2..word.length).each do |index|
          partial_word = word[0...index]
          word_set.add(partial_word)
          if doc_body.has_key?(partial_word)
            doc_body[partial_word] += 1
          else
            doc_body[partial_word] = 1
          end
        end
      end
    end

    df = {}
    idf = {}
    tf_idf = {}
    size = Wikipage.all.count

    # document frequency 를 계산한다.
    word_set.each do |word|
      tf.keys.each do |doc|
        if tf[doc].has_key?(word)
          df.has_key?(word) ? df[word] += 1 : df[word] = 1
        end
      end
    end
    # puts df.inspect

    # inverse document frequency 를 계산한다.
    df.keys.each do |word|
      idf[word] = size / df[word]
    end
    # puts idf.inspect

    # tf-idf 를 계산한다.
    word_set.each do |word|
      tf.keys.each do |doc|
        tf_document = tf[doc]
        if tf_document.has_key?(word)
          tf_idf[doc] = {} if tf_idf[doc].nil?
          tf_idf[doc][word] = tf_document[word] * idf[word] if df.has_key?(word)
        end
      end
    end
    # puts df_idf.inspect

    Wikipage.all.each do |origin|
      score = {}
      Wikipage.all.each do |page|
        next if origin.title == page.title

        # 원본문서와 대조문서에 있는 단어들을 골라낸다.
        matching_words = Set.new
        word_set.each do |word|
          matching_words.add(word) if tf[origin.title].has_key?(word) && tf[page.title].has_key?(word)
        end

        next if matching_words.size == 0

        sum = 0
        origin_v = 0
        page_v = 0
        matching_words.each do |word|
          sum += tf_idf[origin.title][word] * tf_idf[page.title][word]
          origin_v += tf_idf[origin.title][word] ** 2
          page_v += tf_idf[page.title][word] ** 2
        end

        cosine_sim = sum / (Math.sqrt(origin_v) * Math.sqrt(page_v))
        score[page.title] = cosine_sim
        # puts ''
        # puts 'origin: ' + origin.title + ', differ: ' + page.title
        # puts 'sum: ' + sum.to_s + ', origin: ' + origin_v.to_s + ', page: ' + page_v.to_s + ', ' + cosine_sim.to_s
        # puts ''
        # puts ''

      end

      # 원본문서와 대조문서에 연관도가 0.8 이상이라면 관련문서에 연결시킨다.
      sorted_page = score.sort_by { |t, s| -s}
      sorted_page.each do |item|
        break if item[1] < 0.8
        # TODO: 문서가 많아져서 필터링이 좋아진다면 점수를 조졍해야 한다.
        origin.similar_pages.each {|p| p.destroy}
        SimilarPage.create({wikipage_id: origin.id, title: item[0], score: item[1]})
      end
    end
  end

end

