class CweObservedExample < ActiveRecord::Base
	belongs_to :observable, polymorphic: true
end
