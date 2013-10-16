class FacebookController < ApplicationController

  layout "facebook"

  before_filter :require_fb_graph_authentication, :only => [:index, :permissions, :recruitment_methods, :recruitment_mockup, :relationships, :save_relationships, :total_male_friends]


  #  Facebook recommends using a Channel File, which "greatly improves the performance of the [Facebook] JS
  #  SDK by addressing issues with cross-domain communication in certain browsers".  For more info, see:
  #     https://developers.facebook.com/docs/reference/javascript/#channel
  def channel
    render :layout => false
  end

  def index
  end

  def login
  end

  def permissions
    @current_permissions = fb_graph_user.permissions
  end

  def recruitment_methods
  end

  def recruitment_mockup
    @invitation_url = url_for :controller => 'recruit', :action => 'invitation', :id => SecureRandom.hex(16)
  end

  def relationships
    graph_page = "me/friends?fields=interested_in,name,id,gender,relationship_status,significant_other" +
      "&access_token=#{facebook_access_token}"

    fetched_page = FbGraph::Page.fetch(graph_page)
    friend_data = fetched_page.raw_attributes['data']   # TODO: Surely there's a better way than calling raw_attributes...

    @genders = ['male', 'female', nil]
    @relationship_statuses = [
      "Single",
      "In a relationship",
      "Engaged",
      "Married",
      "It's complicated",
      "In an open relationship",
      "Widowed",
      "Separated",
      "Divorced",
      "In a civil union",
      "In a domestic partnership"
    ]

    @total_friends = friend_data.size

    @friends_by_gender = Hash.new
    @friends_in_relationship_by_gender = Hash.new
    @friends_by_gender_by_relationship = Hash.new
    @friends_with_significant_other_by_gender = Hash.new
    
    @genders.each do |gender|
      @friends_by_gender[gender] = friend_data.select { |friend| friend["gender"] == gender }

      @friends_in_relationship_by_gender[gender] = @friends_by_gender[gender].select { |friend| 
        friend.has_key?("relationship_status")
      }

      @friends_with_significant_other_by_gender[gender] = @friends_by_gender[gender].select { |friend| 
        friend.has_key?("significant_other")
      }

      @friends_by_gender_by_relationship[gender] = Hash.new
      @relationship_statuses.each do |relationship_status|
        @friends_by_gender_by_relationship[gender][relationship_status] = @friends_by_gender[gender].select { |friend|
          friend.has_key?("relationship_status") && friend["relationship_status"] == relationship_status 
        }
      end
    end

    @total_shared_relationship_status = friend_data.count { |friend| friend.has_key?("relationship_status") }

    gender_by_facebook_id = Hash.new
    friend_data.each do |friend|
      gender_by_facebook_id[friend["id"]] = friend["gender"]
    end

    friends_with_significant_other = friend_data.select { |friend| friend.has_key?("significant_other") }

    friend_facebook_id_set = friend_data.collect { |friend| friend["id"] }.to_set

    significant_other_facebook_id_set = friends_with_significant_other.collect { |friend| 
      friend["significant_other"]["id"] 
    }.to_set

    significant_others_of_unknown_gender = significant_other_facebook_id_set.subtract(friend_facebook_id_set).to_a


    graph_query = "?ids=" + significant_others_of_unknown_gender.join(',') + "&fields=id,gender" +
      "&access_token=#{facebook_access_token}"
    significant_other_gender_page = FbGraph::Page.fetch(graph_query)
    significant_other_gender_data = significant_other_gender_page.raw_attributes   # TODO: Surely there's a better way than calling raw_attributes...

    #  significant_other_gender_data looks like:
    #    {
    #      "access_token => nil, 
    #      "1059286719"=>{"id"=>"1059286719", "gender"=>"female"}, 
    #      "64901770"=>{"id"=>"64901770"},
    #      "1563292800"=>{"id"=>"1563292800", "gender"=>"female"},
    #      ...
    #    }

    significant_other_gender_data.delete('access_token')

    significant_other_gender_data.each do |facebook_id, significant_other_gender|
      gender_by_facebook_id[facebook_id] = significant_other_gender["gender"]
    end

    @total_couples_by_friend_gender_by_so_gender = Hash.new
    @genders.each do |friend_gender|
      @total_couples_by_friend_gender_by_so_gender[friend_gender] = Hash.new
      @genders.each do |so_gender|
        @total_couples_by_friend_gender_by_so_gender[friend_gender][so_gender] =
          @friends_with_significant_other_by_gender[friend_gender].select { |friend|
            gender_by_facebook_id[friend["significant_other"]["id"]] == so_gender
          }.size
      end
    end

    @total_shared_interested_in = friend_data.count { |friend| friend.has_key?("interested_in") }
  end

  def save_relationships
    #  Retrieve Facebook data for current user
    graph_page = "me?fields=interested_in,name,id,gender,relationship_status,significant_other" + 
      "&access_token=#{facebook_access_token}"
    fetched_page = FbGraph::Page.fetch(graph_page)
    user_data = fetched_page.raw_attributes
    u = FacebookUser.find_or_initialize_from_graph_query_fields(user_data)
    u.save!


    #  Retrieve Facebook data for current user's friends
    graph_page = "me/friends?fields=interested_in,name,id,gender,relationship_status,significant_other" +
      "&access_token=#{facebook_access_token}"
    fetched_page = FbGraph::Page.fetch(graph_page)
    friend_data = fetched_page.raw_attributes['data']

    so_facebook_account_numbers = Array.new

    friend_data.each do |friend_fields|
      friend = FacebookUser.find_or_initialize_from_graph_query_fields(friend_fields)
      friend.save! if friend.changed?
      u.find_or_create_friendship_with(friend)

      if friend.significant_other
        so_facebook_account_numbers.append(friend.significant_other.facebook_account_number)
      end
    end


    #  Retrieve Facebook data for significant others
    graph_query = "?ids=" + so_facebook_account_numbers.join(',') + "&fields=id,gender" +
      "&access_token=#{facebook_access_token}"
    significant_other_gender_page = FbGraph::Page.fetch(graph_query)
    significant_other_gender_data = significant_other_gender_page.raw_attributes
    
    #  significant_other_gender_data looks like:
    #    {
    #      "access_token => nil, 
    #      "1059286719"=>{"id"=>"1059286719", "gender"=>"female"}, 
    #      "64901770"=>{"id"=>"64901770"},
    #      "1563292800"=>{"id"=>"1563292800", "gender"=>"female"},
    #      ...
    #    }

    significant_other_gender_data.delete('access_token')

    significant_other_gender_data.each do |facebook_id, significant_other_gender|
      so = FacebookUser.find_or_initialize_by_facebook_account_number(facebook_id)
      so.gender ||= significant_other_gender["gender"]
      so.save! if so.changed?
    end


    render :json => { "total_male_friends" => u.total_male_friends }
  end

  def total_male_friends
    render :json => { "total_male_friends" => facebook_user.total_male_friends }
  end

  def facebook_account_number
    render :json => {"blah" => session[:facebook_account_number] }
  end

end
