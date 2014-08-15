class RenameOldWikipageToRevision < ActiveRecord::Migration
  def up
    rename_table :old_wikipages, :revisions
  end

  def down
    rename_table :revisions, :old_wikipages
  end
end
