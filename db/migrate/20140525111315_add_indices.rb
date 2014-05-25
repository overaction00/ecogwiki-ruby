class AddIndices < ActiveRecord::Migration
  def up
    add_index :users, :id
    add_index :wikipages, :title
    add_index :wikipages, :user_id
    add_index :wikipages, :modifier
    add_index :old_wikipages, :title
    add_index :old_wikipages, :user_id
    add_index :old_wikipages, :modifier
    add_index :preferences, :title
    add_index :preferences, :user_id
    add_index :preferences, :email
    add_index :social_auths, :user_id
    add_index :social_auths, :social_id
    add_index :social_auths, :email
    add_index :similar_pages, :wikipage_id
    add_index :similar_pages, :title
    add_index :tocs, :wikipage_id
    add_index :tocs, :title
    add_index :inverted_indices, :word
    add_index :inverted_indices, :page
  end

  def down
    remove_index :users, :id
    remove_index :wikipages, :title
    remove_index :wikipages, :user_id
    remove_index :wikipages, :modifier
    remove_index :old_wikipages, :title
    remove_index :old_wikipages, :user_id
    remove_index :old_wikipages, :modifier
    remove_index :preferences, :title
    remove_index :preferences, :user_id
    remove_index :preferences, :email
    remove_index :social_auths, :user_id
    remove_index :social_auths, :social_id
    remove_index :social_auths, :email
    remove_index :similar_pages, :wikipage_id
    remove_index :similar_pages, :title
    remove_index :tocs, :wikipage_id
    remove_index :tocs, :title
    remove_index :inverted_indices, :word
    remove_index :inverted_indices, :page
  end
end
