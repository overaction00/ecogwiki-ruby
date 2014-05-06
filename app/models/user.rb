class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :wikipages

  def admin?
    # TODO: 전역 환경설정에서 어드민 계정을 설정하도록 변경
    self.email == 'wormslab@gmail.com'
  end
end
