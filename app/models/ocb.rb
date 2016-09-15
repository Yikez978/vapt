class Ocb < ActiveRecord::Base
	belongs_to :engagement

	default_scope {where(is_active: true)}

	def self.create_new(ocb_number, ocb_start_date, engagement_id)
		ocb = Ocb.new
		ocb.number = ocb_number
		ocb.start_date = ocb_start_date
		ocb.engagement_id = engagement_id
		ocb.save
	end
end
