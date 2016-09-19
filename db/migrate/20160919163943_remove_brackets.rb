class RemoveBrackets < ActiveRecord::Migration
  def change
    drop_table :brackets
    setting = Setting.where(name: "use_bracket_handicaps").first
    if setting.present?
      setting.destroy!
    end
  end
end
