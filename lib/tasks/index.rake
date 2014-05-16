namespace :index do

  require 'set'
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

    h = {}
    word_set = Set.new
    Wikipage.all.each do |page|
      next if page.body.blank?

      only_text = peel_markdown(markdown, page)

      h[page.title] = h.has_key?(page.title) ? h[page.title] : {}
      doc_body = h[page.title]
      only_text.split.map do |word|
        word_set.add(word)
        doc_body.has_key?(word) ? doc_body[word] += 1 : doc_body[word] = 1
      end
    end

    df = {}
    idf = {}
    df_idf = {}
    size = Wikipage.all.count

    # document frequency 를 계산한다.
    word_set.each do |word|
      h.keys.each do |doc|
        if h[doc].has_key?(word)
          df.has_key?(word) ? df[word] += 1 : df[word] = 1
        end
      end
    end

    # inverse document frequency 를 계산한다.
    df.keys.each do |word|
      idf[word] = size / df[word]
    end

    # df-idf 를 계산한다.
    word_set.each do |word|
      h.keys.each do |doc|
        if h[doc].has_key?(word)
          df_idf[doc] = {} if df_idf[doc].nil?
          df_idf[doc][word] = df[word] * idf[word] if df.has_key?(word)
        end
      end
    end

    # puts df_idf.inspect
    Wikipage.all.each do |origin|
      origin_text = peel_markdown(markdown, origin)
      Wikipage.all.each do |page|
        next if origin.title == page.title

        # 원본문서와 대조문서에 있는 단어들을 골라낸다.
        matching_words = Set.new
        origin_text.split.map do |word|
          matching_words.add(word) if h[page.title].has_key?(word)
        end

        next if matching_words.size == 0

        sum = 0
        origin_v = 0
        page_v = 0
        matching_words.each do |word|
          sum += df_idf[origin.title][word] * df_idf[page.title][word]
          origin_v += df_idf[origin.title][word] ** 2
          page_v += df_idf[page.title][word] ** 2
        end
      end
    end
  end

end

