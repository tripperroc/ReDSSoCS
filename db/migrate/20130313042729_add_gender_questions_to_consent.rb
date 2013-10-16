class AddGenderQuestionsToConsent < ActiveRecord::Migration
  def change
    add_column :redssocs_survey_consents, :gender_male,   :boolean
    add_column :redssocs_survey_consents, :gender_female, :boolean
    add_column :redssocs_survey_consents, :gender_other,  :boolean
  end
end
