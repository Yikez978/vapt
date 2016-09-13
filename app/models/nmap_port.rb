class NmapPort < ActiveRecord::Base
  has_many :nmap_cpes
  has_one :nmap_script
end
