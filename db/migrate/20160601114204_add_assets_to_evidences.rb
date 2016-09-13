class AddAssetsToEvidences < ActiveRecord::Migration
  def change
    add_attachment :evidences, :asset
  end
end
