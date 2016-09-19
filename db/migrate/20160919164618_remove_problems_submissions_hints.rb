class RemoveProblemsSubmissionsHints < ActiveRecord::Migration
  def change
    setting = Setting.find_by(name: 'subtract_hint_points_before_solve')

    if setting.present?
      setting.destroy!
    end

    setting = Setting.find_by(name: 'scoreboard_on')
    if setting.present?
      setting.destroy!
    end

    drop_table :problems
    drop_table :hint_requests
    drop_table :hints
    drop_table :submissions
  end
end
