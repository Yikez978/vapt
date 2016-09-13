class CweMaintenanceNote < ActiveRecord::Base
	belongs_to :maintenable, polymorphic: true
end
