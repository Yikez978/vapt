class PopulateHostVulns
	def initialize(engagement_main_id, nessus_host)
		@engagement_main = EngagementMain.find(engagement_main_id)
		@nessus_host = nessus_host
	end

	def populate
		@nessus_host.items.each do |item|
			#if item.severity == 3 || item.severity == 4
				#item.plugin.each do |plugin|
					hv = HostVuln.create!(
						port: item.port,
						severity: item.severity,
						vuln_name: item.plugin.plugin_name,
						synopsis: item.plugin.synopsis,
						engagement_main_id: @engagement_main.id
					)
					item.plugin.references.each do |reference|
						if reference.reference_name.upcase == "CVE"
							hv.cve = reference.value
							hv.save
						end
						if reference.reference_name.upcase == "CWE"
							hv.cwe = reference.value
							hv.save
						end
					end
				#end
			#end
		end
	end
end