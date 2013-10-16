class CreateFacebookFriendships < ActiveRecord::Migration
  def change
    create_table :facebook_friendships do |t|
      t.integer :lower_facebook_user_id
      t.integer :higher_facebook_user_id

      t.timestamps
    end

    change_table :facebook_friendships do |t|
      t.index :lower_facebook_user_id
      t.index :higher_facebook_user_id
    end
  end
end
