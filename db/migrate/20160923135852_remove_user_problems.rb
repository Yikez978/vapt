class RemoveUserProblems < ActiveRecord::Migration
  def change
    drop_table :user_problems
  end
end
