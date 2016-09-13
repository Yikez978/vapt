class CweArchitechturalParadigm < ActiveRecord::Base
	belongs_to :paradigmable, polymorphic: true
end
