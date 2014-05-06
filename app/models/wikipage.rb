class Wikipage < ActiveRecord::Base
  attr_accessible :title, :body, :itemtype, :description, :revision, :user_id,
                  :modifier, :comment, :acl_read, :acl_write, :link_id,
                  :published_at, :published_to

  has_many :old_wikipages

  belongs_to :user

  def fill_in_default(user)
    unless user.nil?
      self.modifier = user.id
      self.user_id = self.modifier
    end
    self.revision = 0
  end

  def update_body(body)
    old_wikipage = self.old_wikipages.new
    old_wikipage.title = self.title
    old_wikipage.body = self.body
    old_wikipage.revision = self.revision
    old_wikipage.user_id = self.user_id
    old_wikipage.published_at = self.published_at
    old_wikipage.published_to = self.published_to
    old_wikipage.save
    self.body = body
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

end
