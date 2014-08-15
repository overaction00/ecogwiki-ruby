class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:write_handler, :remove_handler, :save_sp_preferences]

  def page_handler
    @wikipage = Wikipage.find_by_title(params[:wikipage])
    if @wikipage.nil?
      @wikipage = Wikipage.new({title: params[:wikipage], revision: 0})
    end

    unless params[:action].nil?
      case params[:action]
        when 'edit'
          return render 'home/edit'
        when 'history'
          @revisions = @wikipage.revisions.reorder('created_at desc').page(params[:page])
          return render '/home/revision_history'
        when 'setting'
        when 'revision'
          @revision = @wikipage.revision.where(revision: params[:id].to_i).first
          return render 'home/wikipage/wikipage_layout'
        else
          return render 'home/wikipage/wikipage_layout'
      end
    end
    render 'home/wikipage/wikipage_layout'
  end

  def write_handler
    # 빈 페이지 일 경우 페이지를 생성한다.

    # 페이지를 생성하기 전 validation 체크를 한다.

    # validation 체크 후 문제가 없다면 revision 을 생성한다. (before_save)

    # 저장 후에는 수정을 마친 페이지로 redirection 한다.
    title = params[:wikipage]
    body = params[:body]
    comment = params[:comment]
    user_id = current_user.nil? ? nil : current_user.id
    modifier = current_user.nil? ? nil : current_user.email

    @wikipage = Wikipage.find_by_title(title)
    if @wikipage.nil?
      @wikipage = Wikipage.new({title: title, body: body, comment: comment, user_id: user_id, modifier: modifier, revision: 1})
      unless @wikipage.save
        return render nothing: true, status: :internal_server_error
      end
    elsif @wikipage.body != params[:body] || @wikipage.comment != params[:comment]
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

  def changes
    @wikipages = Wikipage.limit(10).reorder('updated_at desc')
    render 'home/changes'
  end

  def searches
    @words = InvertedIndex.where("word = '#{params[:q]}'")
    render 'home/searches'
  end

  def preference
    @preference = current_user.preference
    render 'home/preference'
  end

  def save_sp_preferences
    title = params[:userpage_title]
    p = Preference.find_by_user_id(current_user.id)
    p = current_user.build_preference if p.nil?
    p.title = title
    p.email = current_user.email
    if p.save
      return redirect_to preference_path
    end
    render nothing: true, status: :internal_server_error
  end

  def sp_markdown
    render text: markdown_to_html(params[:text]), status: :ok
  end

  private
  def generalize_url

  end

end
