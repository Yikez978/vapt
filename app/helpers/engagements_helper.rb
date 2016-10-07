module EngagementsHelper
  # Host Results Summary, count
  def results_summary_critical_count(h)
    return h[4]
  end
  
  def results_summary_high_count(h)
    return h[3]
  end
  
  def results_summary_medium_count(h)
    return h[2]
  end
  
  def results_summary_low_count(h)
    return h[1]
  end
  
  def results_summary_info_count(h)
    return h[0]
  end
  
  def results_summary_total_count(h)
    return h[4] + h[3] + h[2] + h[1] + h[0]
  end
end
