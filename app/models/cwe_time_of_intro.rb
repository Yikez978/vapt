class CweTimeOfIntro < ActiveRecord::Base
	belongs_to :introable, polymorphic: true
end
