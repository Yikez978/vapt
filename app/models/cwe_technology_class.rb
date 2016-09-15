class CweTechnologyClass < ActiveRecord::Base
	belongs_to :technology_classable, polymorphic: true
end
