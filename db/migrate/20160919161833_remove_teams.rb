class RemoveTeams < ActiveRecord::Migration
  def change
    remove_index :hint_requests, :team_id
    remove_column :hint_requests, :team_id

    remove_index :users, :team_id
    remove_column :users, :team_id

    remove_index :submissions, :team_id
    remove_column :submissions, :team_id

    drop_table :teams

    setting = Setting.where(name: "max_submissions_per_team").first
    if setting.present?
      setting.destroy!
    end
  end
end
