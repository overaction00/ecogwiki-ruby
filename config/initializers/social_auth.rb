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