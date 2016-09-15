class NmapWorker
  include Sidekiq::Worker
  
  # sidekiq_options queue: "high"
  sidekiq_options retry: false

  def perform(engagement_file_id, engagement_id, user_id)
    engagement_file = EngagementFile.find(engagement_file_id)
		populate_nmap_result = PopulateNmapResult.new(engagement_file.asset.path)
		populate_nmap_result.populate(user_id, engagement_id)
  end
end
