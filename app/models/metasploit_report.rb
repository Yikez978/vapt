class MetasploitReport < ActiveRecord::Base
  has_many :metasploit_hosts
  has_many :metasploit_events
  has_many :metasploit_services
  has_many :metasploit_module_details
  has_many :metasploit_credential_cores
  has_many :metasploit_credential_origins
  has_many :metasploit_credential_publics
  has_many :metasploit_credential_logins
  has_many :metasploit_credential_privates

  belongs_to :engagement
  belongs_to :user
end
