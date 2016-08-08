class AddDatesToEngagements < ActiveRecord::Migration
  def change
  	add_column :engagements, :start_date, :date
  	add_column :engagements, :end_date, :date
  end
end
