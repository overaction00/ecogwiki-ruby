require 'murmurhash3'

class Wikipage < ActiveRecord::Base
  attr_accessible :title, :body, :revision, :user_id,
                  :modifier, :comment, :acl_read, :acl_write, :link_id

  has_many :tocs
  has_many :revisions
  has_many :similar_pages

  belongs_to :user

  def fill_in_default(user)
    unless user.nil?
      self.user_id = user.id
      self.modifier = user.email
    end
    self.revision = 1
    self.save
  end

  def update_wikipage(params, user)
    if params[:body].blank? || self.body == params[:body]
      return false
    end
    self.body = params[:body]
    self.comment = params[:comment] unless self.comment == params[:comment]
    self.modifier = user.email
    self.revision += 1
    unless self.save
      return false
    end
    self.generate_toc
  end

  def can_write?(user)
    return false if user.nil?
    if self.acl_write.nil?
      return false
    end
    acls = self.acl_write.split(',')
    acls.include?(user.email) || acls.include?('all')
  end

  def user_preference
    Preference.find_by_email(self.modifier)
  end

  def before_save
    revision = self.revisions.new
    revision.title = self.title
    revision.body = self.body
    revision.revision = self.revision
    revision.user_id = self.user_id
    revision.modifier = self.modifier
    revision.comment = self.comment
    revision.save
  end

  private
  def make_header_key(s)
    MurmurHash3::Native128.murmur3_128_str_hash(s).pack('L*').unpack('H*').first
  end

  def generate_toc
    body = self.body

    self.tocs.each {|t| t.destroy } unless self.tocs.nil?

    current_order = 0
    current_depth = 0
    keys = []

    body.each_line do |line|
      m = /^(#+)(\s+)(.+)/.match(line)
      next if m.nil?

      header_len = m[1].length
      raise 'Header must start with 1' if (current_depth - header_len).abs > 1
      current_depth = header_len
      title = m[3]
      key = make_header_key(title)
      until keys.include?(key) do
        key = make_header_key(title + Random.rand(10000).to_s)
        keys.append(key) unless keys.include?(key)
      end

      depth = header_len
      order = current_order
      toc = self.tocs.build({key: key, title: title, depth: depth, order: order})
      unless toc.save
        return false
      end
      current_order += 1
    end
    true
  end

end
