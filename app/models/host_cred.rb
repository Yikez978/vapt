class HostCred < ActiveRecord::Base
	belongs_to :engagement_main

	validates_presence_of :ip
	validates_presence_of :pwdump
	validates_presence_of :password
	validates_presence_of :description
end
