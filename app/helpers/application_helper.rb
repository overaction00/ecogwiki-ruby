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
    page.title + '?rev=' + page.wikipage.revision.to_s
  end
end

def admin?(user)
  puts 'helper admin?----------------------------'
  return false if user.nil?
  user.email == 'wormslab@gmail.com'
end
