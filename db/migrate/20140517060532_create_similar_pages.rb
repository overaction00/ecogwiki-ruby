class CreateSimilarPages < ActiveRecord::Migration
  def change
    create_table :similar_pages do |t|
      t.integer :wikipage_id
      t.string :title
      t.float :score
      t.timestamps
    end
  end
end
