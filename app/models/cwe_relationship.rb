class CweRelationship < ActiveRecord::Base
	belongs_to :relation, polymorphic: true
end
