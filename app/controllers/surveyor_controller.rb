# encoding: UTF-8
module SurveyorControllerCustomMethods
  def self.included(base)
    base.send :layout, 'surveyor_custom'
  end
end

class SurveyorController < ApplicationController
  include Surveyor::SurveyorControllerMethods
  include SurveyorControllerCustomMethods


  def surveyor_finish
    recruit_index_path
    #estimate_index_path
  end

  def create
      surveys = Survey.where(:access_code => params[:survey_code]).order("survey_version DESC")
      if params[:survey_version].blank?
        @survey = surveys.first
      else
        @survey = surveys.where(:survey_version => params[:survey_version]).first
      end
      
      ### Initialize a response set after first getting the facebook id of the user.
      # require_fb_graph_authentication
      authenticate_with_fb_graph
      @response_set = ResponseSet.find_or_create_by_survey_id_and_user_id(@survey.id, 
                                                                          facebook_user.facebook_account_number)


      @response_set.user_id = facebook_user.facebook_account_number
      facebook_response_set = FacebookResponseSet.find_or_create_by_response_set_id(@response_set.id)
      facebook_response_set.facebook_user_id = facebook_user.id
      
      recruiter_coupon = SecureRandom.hex(16)
      session[:recruiter_coupon] = recruiter_coupon
      session[:email_address]  = params[:user][:address]
 
#      if (facebook_response_set.recruitee_coupon != nil && session[:recruitee_coupon] != nil && facebook_response_set.recruitee_coupon != session[:recruitee_coupon])
#         session[:original_coupon] = facebook_response_set.recruitee_coupon
#         redirect_to :controller => "consent", :action => 'wrong_coupon'
#         return
#      else if (FacebookResponseSet.where(recruitee_coupon: session[:recruitee_coupon]).count > 2)
#         redirect_to :controller => "consent", :action => "expired"
#      end

      facebook_response_set.recruiter_coupon = recruiter_coupon
      facebook_response_set.recruitee_coupon = session[:recruitee_coupon]
      facebook_response_set.email_address = params[:user][:address]
      facebook_response_set.save

      save_relationships

 
      session['where_to_go'] = surveyor.edit_my_survey_path(
          :survey_code => @survey.access_code, :response_set_code  => @response_set.access_code)

      if (@survey && @response_set)
        flash[:notice] = t('surveyor.survey_started_success')
        redirect_to(surveyor.edit_my_survey_path(
          :survey_code => @survey.access_code, :response_set_code  => @response_set.access_code))
      else
        flash[:notice] = t('surveyor.Unable_to_find_that_survey')
        redirect_to surveyor_index
      end
  end
end
