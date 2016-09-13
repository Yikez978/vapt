class PopulateHostInfo
	def initialize(engagement_main_id, nmap_host)
		@engagement_main = EngagementMain.find(engagement_main_id)
		@nmap_host = nmap_host
	end

	def populate
		@nmap_host.nmap_ports.each do |nmap_port|
			host = HostInfo.find_by(ip: @engagement_main.host, engagement_main_id: @engagement_main_id)
			if host.blank?
				HostInfo.create!(
					ip: @engagement_main.host,
					mac: @nmap_host.mac,
					host_name: @engagement_main.host_name,
					os: @engagement_main.os,
					service_port: nmap_port.port,
					service_protocol: nmap_port.protocol,
					service_name: nmap_port.service_name,
					service_status: nmap_port.state,
					engagement_main_id: @engagement_main.id
				)
			else
				host.mac = @nmap_host.mac
				host.service_port = nmap_port.port
				host.service_protocol = nmap_port.protocol
				host.service_name = nmap_port.service_name
				host.service_status = nmap_port.state
				host.save
			end
		end
	end
end