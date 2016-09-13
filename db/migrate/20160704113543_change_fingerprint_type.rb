class ChangeFingerprintType < ActiveRecord::Migration
  def change
  	change_column :nmap_ports, :fingerprint, :text
  end
end
