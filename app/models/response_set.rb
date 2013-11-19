class ResponseSet < ActiveRecord::Base
  has_one :facebook_response_set

  include Surveyor::Models::ResponseSetMethods
  #include SurveyorTweaks::Models::ResponseSetMethods

end
