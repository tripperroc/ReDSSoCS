class ConsentController < ApplicationController

  def info_letter

    if request.post?
      if @rsc =  RedssocsSurveyConsent.create(params[:redssocs_survey_consent])
        if !@rsc.eligible?
          redirect_to :action => 'not_eligible'
        end 
      else
         redirect_to :action => 'not_eligible'
      end
    else 
      redirect_to :action => 'index'
    end
  end

  def index
    @rsc = RedssocsSurveyConsent.new
    @recruitee_coupon = session[:recruitee_coupon]
  end

  def not_eligible
  end

end
