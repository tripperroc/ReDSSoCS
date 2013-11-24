class EstimateController < ApplicationController
  def index
    @estimate = Estimate.find_or_create_by_response_set_id(session[:response_set_id])
    @male_facebook_friends = session[:total_male_friends] 
    @estimate.facebook_male_friends = @male_facebook_friends
    @estimate.facebook_gay_friends = 77
    @where_to_go = session['where_to_go']
  end
end
