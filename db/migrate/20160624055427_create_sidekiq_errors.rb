class CreateSidekiqErrors < ActiveRecord::Migration
  def change
    create_table :sidekiq_errors do |t|
      t.text :exception
      t.text :context_hash

      t.timestamps null: false
    end
  end
end
