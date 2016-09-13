module HostScanDetailsHelper
	def label_by_severity(severity)
		case severity
		when 4
			return "label-danger"
		when 3
			return "label-warning"
		when 2
			return "bg-color-medium"
		when 1
			return "label-success"
		when 0
			return "label-primary"
		end
	end

	def get_risk_factor(severity)
		case severity
		when 4
			return "Critical"
		when 3
			return "High"
		when 2
			return "Medium"
		when 1
			return "Low"
		when 0
			return "Info"
		end
	end
end
