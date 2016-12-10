class SubEngagement < ActiveRecord::Base
	belongs_to :engagement

	has_many :pocs
	has_many :system_admins
	has_many :ips

	attr_accessor :poc, :system_admin, :ip
end
