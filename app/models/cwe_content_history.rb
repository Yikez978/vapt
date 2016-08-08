class CweContentHistory < ActiveRecord::Base
	belongs_to :contentable, polymorphic: true

	has_many :cwe_modifications
	has_many :cwe_prev_entry_names
	has_many :cwe_submissions
end
