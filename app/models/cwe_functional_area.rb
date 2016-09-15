class CweFunctionalArea < ActiveRecord::Base
	belongs_to :functionable, polymorphic: true
end
