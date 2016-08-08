class CweCommonConsequence < ActiveRecord::Base
	belongs_to :consequencable, polymorphic:true
end
