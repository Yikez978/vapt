module HostsHelper
	
	def find_os_image(os)
		case os
		when "Linux"
			"fa-linux"
		when "Windows"
			"fa-windows"
		when "Mac"
			"fa-apple"
		end
	end

	def find_engagement_main_state(aasm_state)
		case aasm_state
		when "not_exploited"
			"Not Exploited"
		when "exploited"
			"Exploited"
		when "working"
			"Working"
		end
	end

end
