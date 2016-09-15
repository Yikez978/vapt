class HostVuln < ActiveRecord::Base
	belongs_to :engagement_main

	include AASM

	aasm do
		state :not_verified, initial: true
		state :not_verified, :false_positive, :vulnerable

		event :verified do 
			transitions from: [:not_verified], to: [:false_positive, :vulnerable]
		end
	end
end
