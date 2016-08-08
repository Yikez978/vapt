class AddContentHistoryIdToCweSubmissions < ActiveRecord::Migration
  def change
  	add_column :cwe_submissions, :cwe_content_history_id, :integer
  end
end
