class AddServiceStatusToHostInfo < ActiveRecord::Migration
  def change
  	add_column :host_infos, :service_status, :string
  end
end
