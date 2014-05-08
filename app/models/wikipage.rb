class Wikipage < ActiveRecord::Base
  attr_accessible :title, :body, :revision, :user_id,
                  :modifier, :comment, :acl_read, :acl_write, :link_id

  has_many :old_wikipages

  belongs_to :user

  def fill_in_default(user)
    unless user.nil?
      self.user_id = user.id
      self.modifier = user.email
    end
    self.revision = 0
  end

  def update_wikipage(params, user)
    old_wikipage = self.old_wikipages.new
    old_wikipage.title = self.title
    old_wikipage.body = self.body
    old_wikipage.revision = self.revision
    old_wikipage.user_id = self.user_id
    old_wikipage.modifier = self.modifier
    old_wikipage.comment = self.comment
    old_wikipage.save
    self.body = params[:body] unless self.body == params[:body]
    self.comment = params[:comment] unless self.comment == params[:body]
    self.modifier = user.email
    self.revision += 1
  end

  def can_write?(user)
    return false if user.nil?
    return true if user.admin?
    if self.acl_write.nil?
      return false
    end
    acls = self.acl_write.split(',')
    acls.include?(user.email) || acls.include?('all')
  end

  def user_preference
    Preference.find_by_email(self.modifier)
  end

end
