class Wikipage < ActiveRecord::Base
  attr_accessible :title, :body, :itemtype, :description, :revision, :user_id,
                  :modifier, :acl_read, :acl_write, :link_id, :published_at, :published_to

  def fill_in_default(user)
    self.newer_title = self.title
    self.modifier = self.user_id
    self.user_id = user.id
    self.revision = 1
  end

  def update_body(body)
    self.body = body
    self.revision += 1
  end

  def can_write?(user)
    if self.acl_write.nil? || user.nil?
      return false
    end
    acls = self.acl_write.split(',')
    acls.include?(user.email) || acls.include?('all')
  end
end
