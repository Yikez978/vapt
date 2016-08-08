class AddCaptionToScreenshot < ActiveRecord::Migration
  def change
    add_column :screenshots, :caption, :text
  end
end
