class AddSexualityQuestionsToConsent < ActiveRecord::Migration
  def change
    add_column :redssocs_survey_consents, :orientation, :string
  end
end
