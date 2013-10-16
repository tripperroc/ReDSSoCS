class FacebookUser < ActiveRecord::Base

  has_one :significant_other, :class_name => "FacebookUser", :foreign_key => "so_facebook_user_id"
  has_one :facebook_response_set

  #  ActiveRecord relationships for friendships based on this screencast:
  #    http://railscasts.com/episodes/163-self-referential-association
  #
  #     "Creating a social networking site often requires a self-referential association on the
  #      User model to define friends/followers. In this episode I show how to do exactly that."

  has_many :lower_facebook_friendships, :class_name => "FacebookFriendship", :foreign_key => "lower_facebook_user_id"
  has_many :lower_facebook_friends, :through => :lower_facebook_friendships, :source => :higher_facebook_user

  has_many :higher_facebook_friendships, :class_name => "FacebookFriendship", :foreign_key => "higher_facebook_user_id"
  has_many :higher_facebook_friends, :through => :higher_facebook_friendships, :source => :lower_facebook_user


  before_save :hash_facebook_account_number


  def self.find_or_initialize_from_graph_query_fields(graph_query_fields)
    u = FacebookUser.find_or_initialize_by_facebook_account_number(graph_query_fields["id"])

    u.gender              ||= graph_query_fields["gender"]
    u.interested_in       ||= graph_query_fields["interested_in"] ? graph_query_fields["interested_in"] .sort.join(',') : nil
    u.name                ||= graph_query_fields["name"]
    u.relationship_status ||= graph_query_fields["relationship_status"]

    if graph_query_fields["significant_other"]
      u.significant_other = FacebookUser.find_or_initialize_by_facebook_account_number(graph_query_fields["significant_other"]["id"])
    end

    u
  end


  def facebook_friends
    lower_facebook_friends + higher_facebook_friends
  end

  def facebook_friendships
    lower_facebook_friendships + higher_facebook_friendships
  end

  def find_or_create_friendship_with(other_facebook_user)
    FacebookFriendship.find_or_create_between(self, other_facebook_user)
  end

  def hash_facebook_account_number
    self.hashed_facebook_account_number = Digest::SHA1.hexdigest(self.facebook_account_number.to_s)
  end

  def is_friends_with?(other_facebook_user)
    FacebookFriendship.already_exists?(self, other_facebook_user)
  end

  def total_male_friends
    self.facebook_friends.count { |f| f.gender == "male" }
  end

end
