class CweView < ActiveRecord::Base
	belongs_to :cwe_weakness_catalog

	has_many :cwe_audiences
	
	has_many :cwe_content_histories, as: :contentable
	has_many :cwe_relationships, as: :relation
	has_many :cwe_maintenance_note, as: :maintenable
	has_many :cwe_references, as: :referable
end
