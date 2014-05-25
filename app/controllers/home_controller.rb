class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:write_handler, :remove_handler, :save_sp_preferences]

  def page_handler
    # [] = generalize_url
    @wikipage = Wikipage.find_by_title(params[:wikipage])
    if @wikipage.nil?
      @wikipage = Wikipage.new({title: params[:wikipage]})
      @wikipage.fill_in_default(current_user)
    end

    if params[:view] == 'edit'
      return render 'home/update'
    elsif params[:rev] == 'list'
      @revisions = @wikipage.nil? ? nil : @wikipage.old_wikipages.reorder('created_at desc').page(params[:page])
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
    comment = params[:comment]
    @wikipage = Wikipage.find_by_title(title)
    if @wikipage.nil?
      @wikipage = Wikipage.new({title: title, body: body, comment: comment})
      @wikipage.fill_in_default(current_user)
      @wikipage.revision += 1
    elsif @wikipage.body != params[:body] or @wikipage.comment != params[:comment]
      Wikipage.transaction do
        @wikipage.update_wikipage(params, current_user)
      end
    end

    redirect_to URI.encode('/' + params[:wikipage])
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

  def sp_changes
    @wikipages = Wikipage.limit(10).reorder('updated_at desc')
    render 'home/sp_changes'
  end

  def sp_searches
    @words = InvertedIndex.where("word = '#{params[:q]}'")
    render 'home/sp_searches'
  end

  def sp_preferences
    @preference = current_user.preference
    render 'home/sp_preferences'
  end

  def save_sp_preferences
    title = params[:userpage_title]
    p = Preference.find_by_user_id(current_user.id)
    p = current_user.build_preference if p.nil?
    p.title = title
    p.email = current_user.email
    if p.save
      return redirect_to '/sp.preferences'
    end
    render nothing: true, status: :internal_server_error
  end

  def sp_markdown
    puts '----------------------'
    puts params[:text]
    puts '----------------------'

    render text: markdown_to_html(params[:text]), status: :ok
  end

end
