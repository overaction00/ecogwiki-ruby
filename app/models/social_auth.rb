class SocialAuth < ActiveRecord::Base
  attr_accessible :user_id, :provider, :social_id, :name, :email

  belongs_to :user
end
