class FacebookFriendship < ActiveRecord::Base

  belongs_to :lower_facebook_user,  :class_name => "FacebookUser"
  belongs_to :higher_facebook_user, :class_name => "FacebookUser"


  before_save :enforce_facebook_user_id_sort_order


  def self.already_exists?(facebook_user1, facebook_user2)
    lower, higher = [facebook_user1.id, facebook_user2.id].sort
    
    FacebookFriendship.where("lower_facebook_user_id = ? AND higher_facebook_user_id = ?", lower, higher).exists?
  end

  def self.find_friendship(facebook_user1, facebook_user2)
    lower, higher = [facebook_user1.id, facebook_user2.id].sort
    
    FacebookFriendship.where("lower_facebook_user_id = ? AND higher_facebook_user_id = ?", lower, higher).first
  end

  def self.find_or_create_between(facebook_user1, facebook_user2)
    FacebookFriendship.find_friendship(facebook_user1, facebook_user2) || FacebookFriendship.create_between(facebook_user1, facebook_user2)
  end

  def enforce_facebook_user_id_sort_order
    if self.lower_facebook_user_id > self.higher_facebook_user_id
      self.lower_facebook_user_id, self.higher_facebook_user_id = self.higher_facebook_user_id, self.lower_facebook_user_id
    end
  end


private 

  def self.create_between(facebook_user1, facebook_user2)
    lower, higher = [facebook_user1.id, facebook_user2.id].sort

    ff = FacebookFriendship.new
    ff.lower_facebook_user_id  = lower
    ff.higher_facebook_user_id = higher
    ff.save!
    return ff
  end

end
