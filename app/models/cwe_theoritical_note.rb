class CweTheoriticalNote < ActiveRecord::Base
	belongs_to :theory_notable, polymorphic: true
end
