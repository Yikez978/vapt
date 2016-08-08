class CweMitigation < ActiveRecord::Base
	belongs_to :mitigatable, polymorphic: true
end
