module Devise
  module Strategies
    class SocialAuth < Devise::Strategies::Base
      def valid?
        true
      end

      def authenticate!
        if params[:res][:verified] == 'true'
          resource = User.find_by_email(params[:res][:email])
          success!(resource)
        else
          fail!('Authentication failed')
        end
      end
    end
  end
end

Warden::Manager.after_set_user do |user,auth,opts|
  auth.cookies[:signed_in] = 1
end

Warden::Manager.before_logout do |user,auth,opts|
  auth.cookies.delete :signed_in
end