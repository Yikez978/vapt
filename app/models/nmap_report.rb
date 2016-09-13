class NmapReport < ActiveRecord::Base
  has_many :nmap_hosts
  has_many :nmap_run_stats
  belongs_to :user
  belongs_to :engagement
end
