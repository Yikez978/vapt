class RemoveRegistrationActiveSetting < ActiveRecord::Migration
  def change
    setting = Setting.find_by(name: "registration_active")
    if setting.present?
      setting.destroy!
    end
  end
end
