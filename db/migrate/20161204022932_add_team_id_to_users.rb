class AddTeamIdToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer  "team_id"
      t.index ["team_id"], name: "index_users_on_team_id"
    end
  end
end
