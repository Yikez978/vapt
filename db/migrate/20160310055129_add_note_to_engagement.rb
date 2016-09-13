class AddNoteToEngagement < ActiveRecord::Migration
  def change
  	add_column :engagements, :note, :text
  	add_column :engagements, :note_add_date, :date
  	add_column :engagements, :host_name, :string
  	add_column :engagements, :sys_admin_id, :integer
  	add_column :engagements, :poc_id, :integer
  	add_column :engagements, :ocb_id, :integer

  	remove_column :engagements, :OCB_number
  end
end
