class AddAasmStateToEngagements < ActiveRecord::Migration
  def change
    add_column :engagements, :aasm_state, :string
    #remove_column :engagements, :engagement_status_id
  end
end
