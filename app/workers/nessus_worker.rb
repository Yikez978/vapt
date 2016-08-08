class NessusWorker
  include Sidekiq::Worker
  
  # sidekiq_options queue: "high"
  sidekiq_options retry: false

  def perform(engagement_file_id, engagement_id, user_id)
    engagement_file = EngagementFile.find(engagement_file_id)
    
    output = []
    IO.popen("risu --config-file #{Rails.root.to_s}/risu.cfg #{engagement_file.asset.path} #{user_id} #{engagement_id}").each do |line|
      output << line.chomp
    end
    
    logger.info "===================================================================="
    logger.info output
    logger.info "===================================================================="
    
    # system("risu --config-file #{Rails.root.to_s}/risu.cfg #{engagement_file.asset.path} #{user_id} #{engagement_id}")
    
    nessus_policy = Risu::Models::Policy.where(engagement_id: engagement_id, user_id: user_id).order("id DESC").first || Risu::Models::Policy.first
    
    em = PopulateEngagementMain.new(nessus_policy, user_id, engagement_id)
    em.populate
  end
end
