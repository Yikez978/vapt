module ApplicationHelper
	# Returns full title on per-page basis
  def full_title(page_title = '')
    base_title = competition_name
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def highlited_calendar_class(date)
    if ((date.year == Date.today.year) && (date.month.to_i == Date.today.month.to_i))
      "remove-highlited-calendar"
    end    
  end
  
  # Rails flash messages using Twitter Bootstrap
  # https://gist.github.com/roberto/3344628
  def bootstrap_class_for(flash_type)
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :danger
        "alert-danger"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      when :warning
        "alert-warning"
      else
        flash_type.to_s
    end
  end

end