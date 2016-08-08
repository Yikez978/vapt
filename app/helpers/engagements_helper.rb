module EngagementsHelper
  # def get_critical_vulns_count(nessus_plugins)
  #   if nessus_plugins.nil?
  #     r = 0
  #   else
  #     r = nessus_plugins.where(risk_factor: 'Critical').count
  #   end
  #   return r
  # end
  #
  # def get_high_vulns_count(nessus_plugins)
  #   if nessus_plugins.nil?
  #     r = 0
  #   else
  #   r = nessus_plugins.where(risk_factor: 'High').count
  #   end
  #   return r
  # end
  #
  # def get_medium_vulns_count(nessus_plugins)
  #   if nessus_plugins.nil?
  #     r = 0
  #   else
  #   r = nessus_plugins.where(risk_factor: 'Medium').count
  #   end
  #   return r
  #
  # end
  #
  # def get_low_vulns_count(nessus_plugins)
  #   if nessus_plugins.nil?
  #     r = 0
  #   else
  #   r = nessus_plugins.where(risk_factor: 'Low').count
  #   end
  #   return r
  #
  # end
  #
  # def get_info_vulns_count(nessus_plugins)
  #   if nessus_plugins.nil?
  #     r = 0
  #   else
  #   r = nessus_plugins.where(risk_factor: 'None').count
  #   end
  #   return r
  #
  # end
  #
  # def get_total_vulns_count(nessus_plugins)
  #   if nessus_plugins.nil?
  #     return 0
  #   else
  #     return nessus_plugins.count
  #   end
  # end
  
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
