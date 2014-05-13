class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :facebook_id
  helper_method :markdown_to_html

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def facebook_id
    CONFIG['facebook']['app_id']
  end

  def markdown_to_html(text)
    options = {
        :autolink => true,
        :space_after_headers => true,
        :no_intra_emphasis => true,
        :fenced_code_blocks => true,
        :disable_indented_code_blocks => true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end
end
