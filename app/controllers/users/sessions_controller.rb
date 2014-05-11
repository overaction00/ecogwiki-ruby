class Users::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  def new
    render 'users/sessions/new'
  end

  def create
    @current_user = User.find_by_email(params[:res][:email])
    @current_user = facebook_user(params[:res]) if @current_user.nil?
    return render nothing: true, status: :internal_server_error if @current_user.nil?
    session[:user_id] = @current_user.id
    resource = warden.authenticate!
    sign_in(:user, resource)
    cookies[:provider] = 'facebook'
    render nothing: true, status: :ok
  end

  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    cookies.delete(:provider) unless cookies[:provider].nil?
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield resource if block_given?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end

  private

  def facebook_user(resource)
    begin
    User.transaction do
      user = User.new({email: resource[:email]})
      user.save
      sa = user.social_auths.build
      sa.email = resource[:email]
      sa.social_id = resource[:id]
      sa.name = resource[:name]
      sa.save
      user
    end
    rescue
      nil
    end
  end
end