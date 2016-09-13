class CweWeaknessOrdinality < ActiveRecord::Base
	belongs_to :ordinalable, polymorphic: true
end
