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

def admin?(current_user)
  !current_user.nil? && current_user.email == 'wormslab@gmail.com'
end
