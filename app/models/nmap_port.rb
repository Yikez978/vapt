class NmapPort < ActiveRecord::Base
  has_many :nmap_cpes
  has_one :nmap_script
  belongs_to :nmap_host

  def banner_text
    "#{product} #{version} #{extra_info}"
  end
end
