class CreateWikipages < ActiveRecord::Migration
  def change
    create_table :wikipages do |t|
      # itemtype_path = ndb.StringProperty()
      # title = ndb.StringProperty()
      # body = ndb.TextProperty()
      # description = ndb.StringProperty()
      # revision = ndb.IntegerProperty()
      # comment = ndb.StringProperty()
      # modifier = ndb.UserProperty()
      # acl_read = ndb.StringProperty()
      # acl_write = ndb.StringProperty()
      # inlinks = ndb.JsonProperty()
      # outlinks = ndb.JsonProperty()
      # related_links = ndb.JsonProperty()
      # updated_at = ndb.DateTimeProperty()
      #
      # published_at = ndb.DateTimeProperty()
      # published_to = ndb.StringProperty()
      # older_title = ndb.StringProperty()
      # newer_title = ndb.StringProperty()
      t.string :itemtype
      t.string :title
      t.string :body
      t.string :description
      t.integer :revision
      t.string :comment
      t.integer :user_id
      t.integer :modifier
      t.timestamps
    end
  end
end
