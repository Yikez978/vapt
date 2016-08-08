class AddAasmStateToEngagementMain < ActiveRecord::Migration
  def change
  	add_column :engagement_mains, :aasm_state, :string
  	remove_column :engagement_mains, :exploit_status
  end
end
