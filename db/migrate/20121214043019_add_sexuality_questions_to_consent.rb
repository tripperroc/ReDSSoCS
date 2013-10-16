class AddSexualityQuestionsToConsent < ActiveRecord::Migration
  def change
    add_column :redssocs_survey_consents, :heterosexual, :boolean
    add_column :redssocs_survey_consents, :gay,          :boolean
    add_column :redssocs_survey_consents, :bisexual,     :boolean
    add_column :redssocs_survey_consents, :other,        :boolean
  end
end
