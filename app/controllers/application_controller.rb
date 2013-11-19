class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :authenticated_with_fb_graph?, :facebook_access_token, :facebook_account_number, :facebook_user, :fb_graph_user,
    :current_survey, :current_survey_name

  include Facebooker2::Rails::Controller


private

  def current_survey
    @current_survey ||= Survey.find_by_survey_name(current_survey_name)
  end

  def current_survey_name
    'ReDSSoCS'
  end


  ##  Facebook authentication methods

  def authenticated_with_fb_graph?
    !facebook_access_token.blank?
  end

  def authenticate_with_fb_graph
    auth = FbGraph::Auth.new(Facebooker2.app_id, Facebooker2.secret)
    auth.from_cookie(cookies)   # Raises FbGraph::Exception if authentication fails
    session[:facebook_access_token]   = auth.access_token.to_s
    session[:facebook_account_number] = auth.user.identifier.to_i
  end

  def facebook_access_token
    @facebook_access_token ||= session[:facebook_access_token]
  end

  def facebook_account_number
    @facebook_account_number ||= session[:facebook_account_number]
  end

  def facebook_user
    @facebook_user ||= FacebookUser.find_or_create_by_facebook_account_number(facebook_account_number)
  end

  def fb_graph_user
    @fb_graph_user ||= FbGraph::User.fetch(facebook_account_number, :access_token => facebook_access_token)
  end

  def require_fb_graph_authentication
    if !authenticated_with_fb_graph?
      begin 
        authenticate_with_fb_graph
      rescue FbGraph::Exception => e
        flash[:fb_graph_auth_exception] = e.message
        redirect_to :controller => 'facebook', :action => 'login'
      end
    end
  end

  def unauthenticate_with_fb_graph
    @facebook_access_token   = session[:facebook_access_token]   = nil
    @facebook_account_number = session[:facebook_account_number] = nil
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
    session[:total_male_friends] = u.total_male_friends
  end


end
