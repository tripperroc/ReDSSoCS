class AddGenderQuestionsToConsent < ActiveRecord::Migration
  def change
    add_column :redssocs_survey_consents, :gender,   :string
  end
end
