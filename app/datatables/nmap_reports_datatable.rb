class NmapReportsDatatable
  delegate :params, :link_to, :engagement_host_path, :engagement_engagement_main_path, :best_in_place, :add_badge, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: nmap_hosts.count,
      iTotalDisplayRecords: nmap_hosts.total_entries,
      aaData: data
    }
  end

  private

  def data
    nmap_hosts.each do |nmap_host|
      [
        (link_to engagement_main.host, engagement_host_path(engagement, engagement_main)),
        (best_in_place engagement_main, :ports, url: engagement_engagement_main_path(engagement, engagement_main), nil: "No ports were found"),
        (best_in_place engagement_main, :services, url: engagement_engagement_main_path(engagement, engagement_main)),
        (best_in_place engagement_main, :vulns, url: engagement_engagement_main_path(engagement, engagement_main)),
        (best_in_place engagement_main, :host_name, url: engagement_engagement_main_path(engagement, engagement_main)),
        (best_in_place engagement_main, :os, url: engagement_engagement_main_path(engagement, engagement_main)),
        (best_in_place engagement_main, :aasm_state, url: engagement_engagement_main_path(engagement, engagement_main), as: :select, collection: [["not_exploited", "Not Exploited"], ["exploited", "Exploited"], ["working", "Working"]], class: "eFontSize exploit_status #{add_badge(engagement_main.aasm_state)}"),
        (link_to "Delete", "#", class: "delete-main-link", "data-obj-id" => engagement_main.id)
      ]
    end
  end

  def engagement
    @engagement ||= Engagement.find(params[:engagement_id])
  end

  def nmap_report
    @nmap_report ||= engagement.nmap_reports.first
  end

  def nmap_hosts
    @nmap_hosts ||= fetch_nmap_hosts
  end

  def fetch_nmap_hosts
    nmap_hosts = nmap_report.nmap_hosts.includes(:nmap_ports).order("#{sort_column} #{sort_direction}")
    nmap_hosts = nmap_hosts.page(page).per_page(per_page)
    if params[:sSearch].present?
      nmap_hosts = nmap_hosts.where("port like :search or protocol like :search", search: "%#{params[:sSearch]}%")
    end
    nmap_hosts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[protocol port state service reason product version]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
