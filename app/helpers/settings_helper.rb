module SettingsHelper
	def competition_started?
		start_time = DateTime.strptime(Setting.find_by(name: 'start_time').value, '%m/%d/%Y %I:%M %p')
		DateTime.current.to_i > start_time.to_i
	end

	def competition_ended?
		end_time = DateTime.strptime(Setting.find_by(name: 'end_time').value, '%m/%d/%Y %I:%M %p')
		DateTime.current.to_i > end_time.to_i
	end

	def competition_active?
		competition_started? && !competition_ended?
	end

	def competition_name
		Setting.find_by(name: 'competition_name').try(:value) || ''
	end

	def view_other_profiles?
		(Setting.find_by(name: 'view_other_profiles').try(:value) == "0") ? false : true
	end

end
