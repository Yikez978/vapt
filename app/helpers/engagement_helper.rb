module EngagementHelper
	def add_badge(exploit_status)
		case exploit_status
		when "not_exploited"
			"label label-danger"
		when "working"
			"label label-warning"
		when "exploited"
			"label label-success"
		end
	end

	def add_state_badge(state)
		if state == "open"
			return "label label-success"
		else
			return "label label-danger"
		end
	end
end
