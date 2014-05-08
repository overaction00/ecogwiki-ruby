class Preference < ActiveRecord::Base

  attr_accessible :title, :email

  belongs_to :user
end
