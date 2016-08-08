class AddIntroableIdToCweTimeOfIntros < ActiveRecord::Migration
  def change
  	add_column :cwe_time_of_intros, :introable_id, :integer
  	add_column :cwe_time_of_intros, :introable_type, :string
  end
end
