class AddMethodIdToCweDetectionMethods < ActiveRecord::Migration
  def change
  	add_column :cwe_detection_methods, :method_id, :string
  end
end
