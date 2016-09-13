class CweLanguage < ActiveRecord::Base
	belongs_to :language, polymorphic: true
end
