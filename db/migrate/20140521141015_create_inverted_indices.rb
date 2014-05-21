class CreateInvertedIndices < ActiveRecord::Migration
  def change
    create_table :inverted_indices do |t|
      t.string :word
      t.string :page
      t.integer :count
      t.timestamps
    end
  end
end
