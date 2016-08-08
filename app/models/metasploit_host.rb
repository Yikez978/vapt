class MetasploitHost < ActiveRecord::Base
	has_many :metasploit_host_services
	has_many :metasploit_host_notes
	has_many :metasploit_exploit_attempts
	has_many :metasploit_host_vulns
end
