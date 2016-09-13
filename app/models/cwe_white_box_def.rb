class CweWhiteBoxDef < ActiveRecord::Base
	belongs_to :box_defiable, polymorphic: true
end
