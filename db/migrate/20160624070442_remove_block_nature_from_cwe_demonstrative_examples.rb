class RemoveBlockNatureFromCweDemonstrativeExamples < ActiveRecord::Migration
  def change
  	remove_column :cwe_demonstrative_examples, :block_nature
  	remove_column :cwe_demonstrative_examples, :desc
  	remove_column :cwe_demonstrative_examples, :code_example_lang
  	remove_column :cwe_demonstrative_examples, :code_block
  end
end
