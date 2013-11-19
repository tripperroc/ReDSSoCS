class EstimateController < ApplicationController
  def index
    @estimate = Estimate.new 
    @male_facebook_friends = session[:total_male_friends] 
    @where_to_go = session['where_to_go']
  end
end
