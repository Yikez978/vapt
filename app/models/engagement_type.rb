class EngagementType < ActiveRecord::Base
	has_many :engagements

	scope :by_name, -> {order(:name)}
end
