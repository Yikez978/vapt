class AddLocalRefIdToCweReferences < ActiveRecord::Migration
  def change
  	add_column :cwe_references, :local_ref_id, :string
  end
end
