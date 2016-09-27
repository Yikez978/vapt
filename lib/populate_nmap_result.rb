# 2.1.5 :001 > file_path = '/Users/rajib/Downloads/nmap.xml'
#  => "/Users/rajib/Downloads/nmap.xml"
# 2.1.5 :002 > @xml_doc = Nmap::XML.new(file_path)


require 'nmap/xml'
require 'open3'

class Nmap::Host

  alias_method :original_mac, :mac

  def mac
    val = original_mac
    return val if val.present?
    ports.each do |port|
      script = port.scripts["snmp-info"]
      next if script.blank?
      data = script.split("\n").detect{|i|i =~ /engineIDData/}
      next if data.blank?
      val = data.strip.gsub("engineIDData: ", "")
      return val if val.present?
    end
    return nil
  end
  
end

class PopulateNmapResult
  def initialize(file_path)
    @xml_doc = Nmap::XML.new(file_path)
  end
  
  def populate(user_id, engagement_id)
    # nmap_reports
    nmap_report = NmapReport.new
    nmap_report.path = @xml_doc.path
    nmap_report.name = @xml_doc.scanner.name
    nmap_report.version = @xml_doc.scanner.version
    nmap_report.arguments = @xml_doc.scanner.arguments
    nmap_report.start_time = @xml_doc.scanner.start_time
    nmap_report.xmloutputversion = @xml_doc.version
    nmap_report.scan_type = @xml_doc.scan_info.first.try(:type).try(:to_s)
    nmap_report.protocol = @xml_doc.scan_info.first.try(:protocol).try(:to_s)
    nmap_report.services = @xml_doc.scan_info.first.try(:services).try(:to_s)
    nmap_report.debugging = @xml_doc.debugging # boolean
    nmap_report.verbose = @xml_doc.verbose # boolean
    nmap_report.user_id = user_id
    nmap_report.engagement_id = engagement_id
    nmap_report.save
    # has_one :nmap_host
    # has_many :nmap_run_stats
    
    # nmap_run_stats
    @xml_doc.each_run_stat do |rs|
      run_stat = nmap_report.nmap_run_stats.new
      run_stat.end_time = rs.end_time
      run_stat.elapsed = rs.elapsed
      run_stat.summary = rs.summary
      run_stat.exit_status = rs.exit_status
      run_stat.save
    end
    
    # nmap_hosts
    @xml_doc.each_host do |host|
      nmap_host = nmap_report.nmap_hosts.new
      nmap_host.ip = host.ip
      nmap_host.ipv4 = host.ipv4
      nmap_host.ipv6 = host.ipv6    
      nmap_host.address = host.address
      nmap_host.mac = host.mac
      nmap_host.vendor = host.vendor
      nmap_host.save
      # has_many :nmap_hostnames
      # has_many :nmap_ports
      # has_one :nmap_operating_system
      # has_many :nmap_host_tcptssequences
      # has_many :nmap_host_tcpsequences
      # has_many :nmap_host_ipidsequences
      # has_many :nmap_host_traceroutes
      
      # nmap_hostnames
      host.each_hostname do |h|
        nmap_hostname = nmap_host.nmap_hostnames.new
        nmap_hostname.host_type = h.type
        nmap_hostname.name = h.name
        nmap_hostname.save
      end
    
      # nmap_ports
      host.each_port do |p|
        nmap_port = nmap_host.nmap_ports.new
        nmap_port.protocol = p.protocol.try(:to_s)
        nmap_port.port = p.number
        nmap_port.state = p.state.try(:to_s)
        nmap_port.reason = p.reason
        nmap_port.service_name = p.service.name
        nmap_port.product = p.service.product
        nmap_port.version = p.service.version
        nmap_port.extra_info = p.service.extra_info
        nmap_port.os_type = p.service.os_type
        nmap_port.fingerprint_method = p.service.fingerprint_method
        nmap_port.fingerprint = p.service.fingerprint
        nmap_port.confidence = p.service.confidence
        nmap_port.device_type = p.service.device_type
        nmap_port.save
        # has_many :nmap_cpes
        # has_one :nmap_script
          
        # nmap_script
        nmap_script = nmap_port.build_nmap_script
        nmap_script.key = p.scripts.keys.try(:first)
        nmap_script.value = p.scripts.values.try(:first)
        nmap_script.save   
          
        # nmap_cpes  
        p.service.cpe.each do |cpe|
          nmap_service = nmap_port.nmap_cpes.new
          nmap_service.part = cpe.part.try(:to_s)
          nmap_service.vendor = cpe.vendor.try(:to_s)
          nmap_service.product = cpe.product.try(:to_s)
          nmap_service.version = cpe.version.try(:to_s)
          nmap_service.cpe_update = cpe.update.try(:to_s)
          nmap_service.edition = cpe.edition.try(:to_s)
          nmap_service.language = cpe.language.try(:to_s)
          nmap_service.save
        end
      end
    
      # nmap_operating_systems
      nmap_os = nmap_host.build_nmap_operating_system
      nmap_os.save
      # has_many :nmap_used_ports
      # has_many :nmap_os_matches
      # has_many :nmap_os_classes
      
      # nmap_used_ports
      unless host.os.blank?
        host.os.each_ports_used do |portused|
          nmap_used_ports = nmap_os.nmap_used_ports.new
          nmap_used_ports.state = portused.state
          nmap_used_ports.proto = portused.proto
          nmap_used_ports.portid = portused.portid
          nmap_used_ports.save 
        end
        
        # nmap_os_matches
        host.os.each_match do |match|
          nmap_os_match = nmap_os.nmap_os_matches.new
          nmap_os_match.name = match.name
          nmap_os_match.accuracy = match.accuracy
          nmap_os_match.save 
        end
        
        # nmap_os_classes
        host.os.each_class do |klass|
          nmap_os_class = nmap_os.nmap_os_classes.new
          nmap_os_class.osclass_type = klass.type
          nmap_os_class.vendor = klass.vendor
          nmap_os_class.osfamily = klass.family
          nmap_os_class.osgen = klass.gen
          nmap_os_class.accuracy = klass.accuracy
          nmap_os_class.save 
        end
      end
    
      # nmap_host_uptimes
      unless host.uptime.blank?
        uptime = host.uptime
        nmap_host_uptime = nmap_host.nmap_host_uptimes.new
        nmap_host_uptime.seconds = uptime.seconds
        nmap_host_uptime.last_boot = uptime.last_boot
        nmap_host_uptime.save
      end
    
      # nmap_host_tcptssequences
      unless host.tcptssequence.blank?
        tcptssequence = host.tcptssequence
        nmap_host_tcptssequence = nmap_host.nmap_host_tcptssequences.new
        nmap_host_tcptssequence.values = tcptssequence.values.try(:to_s)
        nmap_host_tcptssequence.description = tcptssequence.description
        nmap_host_tcptssequence.save
      end
    
      # nmap_host_tcpsequences
      unless host.tcpsequence.blank?
        tcpsequence = host.tcpsequence
        nmap_host_tcpsequence = nmap_host.nmap_host_tcpsequences.new
        nmap_host_tcpsequence.index = tcpsequence.index
        nmap_host_tcpsequence.difficulty = tcpsequence.difficulty
        nmap_host_tcpsequence.values = tcpsequence.values.try(:to_s)
        nmap_host_tcpsequence.save
      end
    
      # nmap_host_ipidsequences
      unless host.ipidsequence.blank?
        ipidsequence = host.ipidsequence
        nmap_host_ipidsequence = nmap_host.nmap_host_ipidsequences.new
        nmap_host_ipidsequence.values = ipidsequence.values
        nmap_host_ipidsequence.description = ipidsequence.description
        nmap_host_ipidsequence.save
      end
    
      # nmap_host_traceroutes
      unless host.traceroute.blank?
        traceroute = host.traceroute
        traceroute_entries = host.traceroute.entries
        
        traceroute_entries.each do |t|
          nmap_host_traceroute = nmap_host.nmap_host_traceroutes.new
          nmap_host_traceroute.port = traceroute.port
          nmap_host_traceroute.protocol = traceroute.protocol
          nmap_host_traceroute.ttl = t.ttl
          nmap_host_traceroute.ipaddr = t.addr
          nmap_host_traceroute.rtt = t.rtt
          nmap_host_traceroute.host = t.host
          nmap_host_traceroute.save
        end
      end
    end
    
    # After create populate Engagement Main table
    em = PopulateEngagementMain.new(nmap_report, user_id, engagement_id)
    em.populate
    
    nmap_report.is_completed = true
    nmap_report.save
    return nmap_report.id
  end
end