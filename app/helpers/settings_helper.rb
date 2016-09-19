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

	def send_activation_emails?
		(Setting.find_by(name: 'send_activation_emails').try(:value) == "1") ? true : false
	end

	def view_other_profiles?
		(Setting.find_by(name: 'view_other_profiles').try(:value) == "0") ? false : true
	end

	def entry_cost
		Setting.find_by(name: 'entry_cost').try(:value)
	end

	def fifty_percent_off
		Setting.find_by(name: 'fifty_percent_off').try(:value)
	end

	def one_hundred_percent_off
		Setting.find_by(name: 'one_hundred_percent_off').try(:value)
	end

end
