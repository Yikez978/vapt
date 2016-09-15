class SystemAdmin < ActiveRecord::Base
	belongs_to :engagement
	belongs_to :sub_engagement
	belongs_to :user

	def self.create_new(names_string, engagement_id, sub_engagement_id=nil)
		names_array = names_string.split(",").map(&:strip).uniq
		names_array.each do |name|
      SystemAdmin.create(name: name, engagement_id: engagement_id)
		end
	end
end
