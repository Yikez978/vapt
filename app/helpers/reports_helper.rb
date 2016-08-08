module ReportsHelper
  def make_name_tag(field, vulnerability_id)
    "report[options][penetrations][#{vulnerability_id.to_s}][#{field}]"
  end

  def make_absolute_url(str)
  	formated_str = ""
    if str.include? "<img"
  		formated_str = str.insert(str.index("<img")+17, request.base_url)
  	else
  		formated_str = str
  	end
  	return formated_str
  end

  def add_severity_class(severity)
  	case severity
  	when "critical"
  		return "critical"
  	when "high"
  		return "high"
  	when "medium"
  		return "medium"
  	when "low"
  		return "low"
  	when "info"
  		return "info"
  	end
  end
end
