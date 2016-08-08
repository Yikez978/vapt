class CweRelatedAttackPattern < ActiveRecord::Base
	belongs_to :attackable, polymorphic: true
end
