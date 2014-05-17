class CreateRelatedPages < ActiveRecord::Migration
  def change
    create_table :related_pages do |t|
      t.integer :wikipage_id
      t.string :title
      t.float :score
      t.timestamps
    end
  end
end
