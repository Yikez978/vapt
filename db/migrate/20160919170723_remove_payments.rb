class RemovePayments < ActiveRecord::Migration
  def change
    setting = Setting.find_by(name: 'require_payment')
    if setting.present?
      setting.destroy!
    end

    remove_column :users, :paid
  end
end
