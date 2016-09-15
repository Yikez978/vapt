class CweTaxonomy < ActiveRecord::Base
	belongs_to :taxonomy, polymorphic: true
end
