class CweDetectionMethod < ActiveRecord::Base
	belongs_to :detectable, polymorphic: true
end
