class AddSubmissionDateToCweSubmissions < ActiveRecord::Migration
  def change
  	add_column :cwe_submissions, :submission_date, :date
  end
end
