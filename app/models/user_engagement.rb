class UserEngagement < ActiveRecord::Base
	belongs_to :user
	belongs_to :engagement

	def self.available_engagements(user_id)
    user = User.find(user_id)
    
    # Available engagments where user not joined, but some of them are there where user has joined and other user has also joined.
    available_engagments_user_not_joined = Engagement.joins("LEFT OUTER JOIN `user_engagements` ON `user_engagements`.`engagement_id` = `engagements`.`id`").select("engagements.id as id, engagements.engagement_name as engagement_name, user_engagements.user_id as user_id").where("user_engagements.user_id NOT IN (?) OR user_engagements.user_id IS NULL", user_id)
    
    # User already joined engagements 
    user_joined_engagments = user.engagements
    
    # Get ids of actual engagements which are available
    final_available_engagement_ids = (available_engagments_user_not_joined.map {|i| i.id}) - (user_joined_engagments.map {|i| i.id})
    
    return Engagement.find(final_available_engagement_ids)
	end
end