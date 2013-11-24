class RecruitController < ApplicationController

  layout "recruit"

  def index   
    @invitation_url = url_for :controller => 'recruit', :action => 'invitation', :id => session[:recruiter_coupon]
    @email = session[:email_address]
    @male_facebook_friends = session[:total_male_friends]
    q = Question.find_by_reference_identifier("estimate_total_facebook_gb_men")
    #logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #logger.debug q.id
    #logger.debug session[:response_set]
    
    r = Response.find_by_question_id_and_response_set_id(q.id, session[:response_set])
    @gay_facebook_friends = r.integer_value
    ResponderMailer.thank_you_email({:invitation_url => @invitation_url, :email_address => @email}).deliver
  end

  def invitation
    session[:recruitee_coupon] = params[:id]
    redirect_to :controller => 'consent', :action => 'index'
  end

  def email
    session[:email] = params[:email]
    render :json => { "mmail" => params[:email] }
 
  end

end
