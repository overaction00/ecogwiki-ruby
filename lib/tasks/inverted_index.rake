namespace :inverted_index do

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

    word_set = {}
    Wikipage.all.each do |page|
      body = peel_markdown(markdown, page)
      body.split.each do |word|
        (1..word.length-1).each do |len|
          partial_word = word[0..len]
          word_set[partial_word] = {} unless word_set.has_key?(partial_word)
          count_map = word_set[partial_word]
          count_map.has_key?(page.title) ? count_map[page.title] += 1 : count_map[page.title] = 1
        end
      end
    end

    InvertedIndex.all.each { |x| x.destroy }
    InvertedIndex.transaction do
      word_set.keys.each do |word|
        word_set[word].keys.each do |page|
          InvertedIndex.create({word: word, page: page, count: word_set[word][page]})
        end
      end
    end
  end
end