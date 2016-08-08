class PopulateEngagementMain
  # obj_id will be NmapReport id or Risu::Models::Policy id
  def initialize(_obj, user_id, engagement_id)
    puts "**********#{_obj.class.to_s}**********"
    if _obj.class.to_s == "NmapReport"
      @nmap_report = _obj
    elsif _obj.class.to_s == "Risu::Models::Policy"
      @nessus_policy = _obj
    elsif _obj.class.to_s == "MetasploitReport"
      @metasploit_report = _obj
    end
    
    @user_id = user_id
    @engagement_id = engagement_id
  end
  
  def populate
    if @nmap_report
      nmap_hosts = @nmap_report.nmap_hosts
      nmap_hosts.each do |nmap_host|
        em = EngagementMain.find_by(host: nmap_host.ip, user_id: @user_id, engagement_id: @engagement_id)
        if em.blank?
          em = EngagementMain.create(
                host: nmap_host.ip,
                mac: nmap_host.mac,
                vulns: 0,
                user_id: @user_id,
                engagement_id: @engagement_id
          )
        else
          em.update_attributes(
            mac: nmap_host.mac
          )
          em.save
        end
        nmap_host.nmap_hostnames.each do |nmap_hostname|
          nmap_os_classes = nmap_host.nmap_operating_system.try(:nmap_os_classes)
          nmap_ports = []
          nmap_host.nmap_ports.each do |nmap_port|
            unless nmap_port.port == "0"
              nmap_ports << nmap_port.port
            end
          end
          em.update_attributes(
            ports: nmap_ports.uniq.join(","),
            host_name: nmap_hostname.name
          )
          nmap_os_classes.each do |nmap_os_class|
            em.update_attributes(
              os: nmap_os_class.osfamily
            )
            em.save
          end
        end
      hostInfo = PopulateHostInfo.new(em.id, nmap_host)
      hostInfo.populate
      end
    elsif @nessus_policy
      nessus_hosts = (@nessus_policy.nessus_reports.map {|r| r.hosts}).flatten
      nessus_hosts.each do |nessus_host|
        nessus_ports = []
        nessus_services = []
        nessus_host.items.each do |item|
          unless item.port == 0
            nessus_ports << item.port
          end
          unless item.svc_name == "general"
            nessus_services << item.svc_name
          end
        end
        em = EngagementMain.find_by(host: nessus_host.ip, user_id: @user_id, engagement_id: @engagement_id)
        if em.blank?
          em = EngagementMain.create(
            host: nessus_host.ip,
            ports: nessus_ports.uniq.join(","),
            services: nessus_services.uniq.join(","),
            vulns: nessus_host.items.size,
            host_name: nessus_host.name,
            os: nessus_host.os,
            mac: nessus_host.mac,
            user_id: @user_id,
            engagement_id: @engagement_id
          )
        else
          em.update_attributes(
            ports: nessus_ports.uniq.join(","),
            services: nessus_services.uniq.join(","),
            vulns: nessus_host.items.size,
            host_name: nessus_host.name,
            os: nessus_host.os,
            mac: nessus_host.mac
          )
          em.save
        end
        
        hostinfo = HostInfo.find_by(ip: nessus_host.ip, engagement_main_id: em.id) 
        if hostinfo.blank?
          HostInfo.create(
            ip: nessus_host.ip,
            host_name: nessus_host.name,
            os: nessus_host.os,
            engagement_main_id: em.id
          )
        else
          hostinfo.update_attributes(
            host_name: nessus_host.name,
            os: nessus_host.os
          )
          hostinfo.save
        end

        hostVulns = PopulateHostVulns.new(em.id, nessus_host)
        hostVulns.populate
      end
    elsif @metasploit_report
      metasploit_hosts = @metasploit_report.metasploit_hosts
      metasploit_hosts.each do |host|
        metasploit_service_names = []
        host.metasploit_host_services.each do |service|
          metasploit_service_names << service.name
        end
        em = EngagementMain.find_by(host: host.address, user_id: @user_id, engagement_id: @engagement_id)
        if em.blank?
          em = EngagementMain.create!(
            host: host.address,
            services: metasploit_service_names.uniq.join(","),
            vulns: host.metasploit_host_vulns.size,
            mac: host.mac,
            os: host.os_name,
            host_name: host.name,
            user_id: @user_id,
            engagement_id: @engagement_id
          )
        else
          em.update_attributes(
            host: host.address,
            services: metasploit_service_names.uniq.join(","),
            vulns: host.metasploit_host_vulns.size,
            mac: host.mac,
            os: host.os_name,
            host_name: host.name
          )
          em.save!
        end

        hostinfo = HostInfo.find_by(ip: host.address, engagement_main_id: em.id)
        if hostinfo.blank?
          HostInfo.create(
            ip: host.address,
            host_name: host.name,
            os: host.os_name,
            mac: host.mac,
            engagement_main_id: em.id
          )
        else
          hostinfo.update_attributes(
            ip: host.address,
            host_name: host.name,
            os: host.os_name,
            mac: host.mac
          )
          hostinfo.save
        end
      end
    end
  end
end