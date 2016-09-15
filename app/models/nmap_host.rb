class NmapHost < ActiveRecord::Base
  has_many :nmap_hostnames
  has_many :nmap_ports
  has_one :nmap_operating_system
  has_many :nmap_host_uptimes
  has_many :nmap_host_tcptssequences
  has_many :nmap_host_tcpsequences
  has_many :nmap_host_ipidsequences
  has_many :nmap_host_traceroutes

  belongs_to :nmap_report
end
