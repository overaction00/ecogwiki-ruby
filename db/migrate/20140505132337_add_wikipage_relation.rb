class AddWikipageRelation < ActiveRecord::Migration
  def up
    add_column :old_wikipages, :wikipage_id, :integer
  end

  def down
    remove_column :old_wikipages, :wikipage_id
  end
end
