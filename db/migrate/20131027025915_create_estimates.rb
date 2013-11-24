class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :response_set_id
      t.integer :male_friends
      t.integer :gay_friends
      t.integer :facebook_male_friends
      t.integer :facebook_gay_friends
      t.string :accuracy
      t.integer :right_percentage

      t.timestamps
    end
  end
end
