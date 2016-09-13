class CweDemonstrativeExample < ActiveRecord::Base
	belongs_to :demo_example, polymorphic: true

	has_many :code_blocks
end
