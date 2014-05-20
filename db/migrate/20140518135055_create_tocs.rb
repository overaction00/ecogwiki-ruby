class CreateTocs < ActiveRecord::Migration
  def change
    create_table :tocs do |t|
      t.integer :wikipage_id
      t.string :key
      t.string :title
      t.integer :depth
      t.integer :order
      t.timestamps
    end
  end
end
