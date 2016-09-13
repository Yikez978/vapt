class EngagementMainUser < ActiveRecord::Base
  belongs_to :users
  belongs_to :engagement_mains
end
