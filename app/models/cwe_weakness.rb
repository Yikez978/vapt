class CweWeakness < ActiveRecord::Base
	belongs_to :cwe_weakness_catalog

	has_many :cwe_relationships, as: :relation
	has_many :cwe_languages, as: :language
	has_many :cwe_maintenance_notes, as: :maintenable
	has_many :cwe_weakness_ordinalities, as: :ordinalable
	has_many :cwe_time_of_intros, as: :introable
	has_many :cwe_common_consequences, as: :consequencable
	has_many :cwe_mitigations, as: :mitigatable
	has_many :cwe_demonstrative_examples, as: :demo_example
	has_many :cwe_observed_examples, as: :observable
	has_many :cwe_detection_methods, as: :detectable
	has_many :cwe_taxonomies, as: :taxonomy
	has_many :cwe_references, as: :referable
	has_many :cwe_related_attack_patterns, as: :attackable
	has_many :cwe_content_histories, as: :contentable
	has_many :cwe_technology_classes, as: :technology_classable
	has_many :cwe_relationship_notes, as: :relationship_notable
	has_many :cwe_alternate_terms, as: :alternate_termable
	has_many :cwe_theoritical_notes, as: :theory_notable
	has_many :cwe_research_gaps, as: :research_gapable
	has_many :cwe_functional_areas, as: :functionable
	has_many :cwe_mode_of_intros, as: :mode_introable
	has_many :cwe_architechtural_paradigms, as: :paradigmable
end
