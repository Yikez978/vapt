class AddDatesToOcb < ActiveRecord::Migration
  def change
  	add_column :ocbs, :start_date, :date
  	add_column :ocbs, :end_date, :date
  end
end
