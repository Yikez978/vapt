class AddBlockNatureToCodeBlocks < ActiveRecord::Migration
  def change
  	add_column :code_blocks, :block_nature, :string
  end
end
