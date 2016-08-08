class RemoveCweCategoryIdFromCweTimeOfIntro < ActiveRecord::Migration
  def change
  	remove_column :cwe_time_of_intros, :cwe_category_id
  end
end
