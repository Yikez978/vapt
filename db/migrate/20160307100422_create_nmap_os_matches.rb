class CreateNmapOsMatches < ActiveRecord::Migration
  def change
    create_table :nmap_os_matches do |t|
      t.integer :nmap_operating_system_id
      t.string :name
      t.string :accuracy
      #t.string :line

      t.timestamps null: false
    end
  end
end
