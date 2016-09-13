class AddCodeBlockToCweDemonstrativeExample < ActiveRecord::Migration
  def change
  	add_column :cwe_demonstrative_examples, :code_block, :text
  end
end
