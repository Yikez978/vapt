class CweModeOfIntro < ActiveRecord::Base
	belongs_to :mode_introable, polymorphic: true
end
