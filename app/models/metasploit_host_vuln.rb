class MetasploitHostVuln < ActiveRecord::Base
	has_many :metasploit_refs
end
