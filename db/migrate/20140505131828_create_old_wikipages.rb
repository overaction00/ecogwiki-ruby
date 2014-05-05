class CreateOldWikipages < ActiveRecord::Migration
  def change
    create_table :old_wikipages do |t|
      t.string :title
      t.string :body
      t.integer :revision
      t.integer :user_id
      t.datetime :published_at
      t.string :published_to
      t.timestamps
    end
  end
end
