class RecruitController < ApplicationController

  layout "recruit"

  def index   
    @invitation_url = url_for :controller => 'recruit', :action => 'invitation', :id => session[:recruiter_coupon]
  end

  def invitation
    session[:recruitee_coupon] = params[:id]
    redirect_to :controller => 'consent', :action => 'index'
  end

end
