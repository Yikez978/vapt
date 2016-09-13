class NmapOperatingSystem < ActiveRecord::Base
  has_many :nmap_used_ports
  has_many :nmap_os_matches
  has_many :nmap_os_classes
end
