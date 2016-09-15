class AddIndexToScreenshot < ActiveRecord::Migration
  def change
    add_column :screenshots, :index, :integer
  end
end
