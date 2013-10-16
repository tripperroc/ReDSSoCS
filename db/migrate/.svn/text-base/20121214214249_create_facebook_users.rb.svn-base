class CreateFacebookUsers < ActiveRecord::Migration
  def change
    create_table :facebook_users do |t|
      t.integer :so_facebook_user_id

      t.column :facebook_account_number, 'bigint'
      t.string :hashed_facebook_account_number

      t.string :gender
      t.string :interested_in
      t.string :name    # Used only for debugging
      t.string :relationship_status

      t.timestamps
    end

    change_table :facebook_users do |t|
      t.index :so_facebook_user_id

      t.index :facebook_account_number
      t.index :hashed_facebook_account_number
      
      t.index :gender
      t.index :interested_in
      t.index :relationship_status
    end
  end
end
