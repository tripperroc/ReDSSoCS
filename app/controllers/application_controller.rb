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

end
