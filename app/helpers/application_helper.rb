require 'redcarpet'
require 'trie'

module ApplicationHelper
  def markdown_to_html(text)
    options = {
        :autolink => true,
        :space_after_headers => true,
        :no_intra_emphasis => true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

  def absolute_path(page)
    if page.class.to_s == 'String'
      '/' + page
    elsif page.class.to_s == 'Wikipage' || page.class.to_s == 'OldWikipage'
      '/' + page.title + '?rev=' + page.wikipage.revision.to_s
    else
      page
    end
  end

  def admin?(user)
    return false if user.nil?
    user.email == CONFIG[:admin]
  end

  def page_modifier(page)
    user_preference = page.user_preference
    user_preference.nil? ? page.modifier : user_preference.title
  end

  def page_type(page)
    'other'
  end
end


