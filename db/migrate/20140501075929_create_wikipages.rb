class CreateWikipages < ActiveRecord::Migration
  def change
    create_table :wikipages do |t|
      t.string :title
      t.string :body
      t.integer :revision
      t.string :comment
      t.integer :user_id # owner
      t.string :modifier # modifier
      t.string :acl_read
      t.string :acl_write
      t.integer :link_id # related with (in links, out links, related links)
      t.timestamps
    end
  end
end
