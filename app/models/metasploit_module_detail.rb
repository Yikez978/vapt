class MetasploitModuleDetail < ActiveRecord::Base
	has_many :metasploit_module_authors
	has_many :metasploit_module_refs
	has_many :metasploit_module_archs
	has_many :metasploit_module_platforms
	has_many :metasploit_module_targets
end
