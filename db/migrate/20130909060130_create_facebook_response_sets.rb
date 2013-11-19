class CreateFacebookResponseSets < ActiveRecord::Migration
  def self.up
    create_table :facebook_response_sets do |t|
      # Context
      t.integer :facebook_user_id
      t.integer :response_set_id

      # Content
      t.string :recruitee_coupon
      t.string :recruiter_coupon
      t.string :email_address

      t.timestamps
    end
  end

  def self.down
    drop_table :facebook_response_sets
  end
end
