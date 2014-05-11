class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.string :title
      t.string :email
      t.timestamps
    end
  end
end