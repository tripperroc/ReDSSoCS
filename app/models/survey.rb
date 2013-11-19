class Survey < ActiveRecord::Base
  include Surveyor::Models::SurveyMethods
#  include SurveyorTweaks::Models::SurveyMethods

end
