require 'redcarpet'

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class HomeController < ApplicationController
  def index
  end

  def page_handler
    # [] = generalize_url
    @wikipage = Wikipage.find_by_title(params[:wikipage])
    if params[:view] == 'edit'
      return render 'home/update'
    elsif params[:rev] == 'list'
      @revisions = @wikipage.nil? ? nil : @wikipage.old_wikipages
      return render '/home/show_rev'
    elsif !params[:rev].nil? && params[:rev].numeric?
      return redirect_to '/' + params[:wikipage] if @wikipage.nil?

      if @wikipage.revision < params[:rev].to_i
        return redirect_to '/' + params[:wikipage] + '?rev=' + @wikipage.revision.to_s
      end

      @revision = @wikipage.old_wikipages.where(revision: params[:rev].to_i).first
    end

    render 'home/show'
  end

  def write_handler
    title = params[:wikipage]
    body = params[:body]
    @wikipage = Wikipage.find_by_title(title)
    if @wikipage.nil?
      @wikipage = Wikipage.new({title: title, body: body})
      @wikipage.fill_in_default(current_user)
    else
      @wikipage.update_body(body)
    end

    if @wikipage.save
      return redirect_to '/' + params[:wikipage]
    end
    render nothing: true, status: :internal_server_error
  end

  def update_handler
    render(status: :ok, nothing: true)
  end

  def remove_handler
    @wikipage = Wikipage.find_by_title(params[:wikipage])
    @wikipage.destroy
    if @wikipage.save
      return render nothing: true, status: :ok
    end
    render nothing: true, status: :internal_server_error
  end

  def root_handler
    redirect_to '/Home'
  end

  def markdown
    text = params[:text]
    options = {
        :autolink => true,
        :space_after_headers => true,
        :no_intra_emphasis => true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    render text: markdown.render(text).html_safe, status: :ok
  end

end
