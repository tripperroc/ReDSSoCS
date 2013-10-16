class CreateRedssocsSurveyConsents < ActiveRecord::Migration
  def change
    create_table :redssocs_survey_consents do |t|
      t.boolean :eighteen_or_older
      t.boolean :read_and_understand
      t.boolean :dont_meet_all_criteria

      t.timestamps
    end
  end
end
