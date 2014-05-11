class CreateSocialAuths < ActiveRecord::Migration
  def change
    create_table :social_auths do |t|
      t.integer :user_id
      t.string :provider
      t.string :social_id
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
