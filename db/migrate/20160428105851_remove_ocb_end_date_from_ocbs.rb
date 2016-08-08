class RemoveOcbEndDateFromOcbs < ActiveRecord::Migration
  def change
    remove_column :ocbs, :end_date
  end
end