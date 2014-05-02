class CreateWikipages < ActiveRecord::Migration
  def change
    create_table :wikipages do |t|
      t.string :itemtype # according to schema.org
      t.string :title
      t.string :body
      t.string :description
      t.integer :revision
      t.string :comment
      t.integer :user_id
      t.integer :modifier
      t.string :acl_read
      t.string :acl_write
      t.integer :link_id # related with (in links, out links, related links)
      t.datetime :published_at
      t.string :published_to
      t.string :older_title
      t.string :newer_title
      t.timestamps
    end
  end
end
