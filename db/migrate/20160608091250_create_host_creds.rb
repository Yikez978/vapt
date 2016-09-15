class CreateHostCreds < ActiveRecord::Migration
  def change
    create_table :host_creds do |t|
      t.string :ip
      t.text :pwdump
      t.string :password
      t.text :description
      t.integer :engagement_main_id

      t.timestamps null: false
    end
  end
end
