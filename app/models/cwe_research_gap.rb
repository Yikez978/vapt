class CweResearchGap < ActiveRecord::Base
	belongs_to :research_gapable, polymorphic: true
end
