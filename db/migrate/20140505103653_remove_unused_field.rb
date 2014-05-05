class RemoveUnusedField < ActiveRecord::Migration
  def up
    remove_column :wikipages, :older_title
    remove_column :wikipages, :newer_title
  end

  def down
    add_column :wikipages, :older_title, :string
    add_column :wikipages, :newer_title, :string
  end
end
