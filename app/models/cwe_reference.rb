class CweReference < ActiveRecord::Base
	belongs_to :referable, polymorphic: true
end
