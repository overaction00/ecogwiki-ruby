require 'redcarpet'

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
      page.title + '?rev=' + page.wikipage.revision.to_s
    else
      page
    end
  end
end

def admin?(user)
  return false if user.nil?
  user.email == 'wormslab@gmail.com'
end
