class RenameField < ActiveRecord::Migration
  def up
    rename_column :wikipages, :comment_id, :comment
  end

  def down
    rename_column :wikipages, :comment, :comment_id
  end
end
