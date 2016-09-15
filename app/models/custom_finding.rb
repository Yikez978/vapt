class CustomFinding < ActiveRecord::Base
	belongs_to :engagement_main

	validates_presence_of :host
	validates_presence_of :port
	validates_presence_of :service
	validates_presence_of :desc
end
