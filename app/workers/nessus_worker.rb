require 'open3'

class NessusWorker
  include Sidekiq::Worker
  
  # sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(engagement_file_id, engagement_id, user_id)
    engagement_file = EngagementFile.find(engagement_file_id)

    output = []
    status = 0 
    Open3.popen2("risu --config-file #{Rails.root.to_s}/risu.cfg #{engagement_file.asset.path} #{user_id} #{engagement_id}") do |stdin, stdout, wait_thr|
     output << stdout
     wait_thr.join
     status = wait_thr.value
    end

    raise IOError, "risu process failed" unless status.success?
    
    logger.info "===================================================================="
    logger.info output
    logger.info "===================================================================="
    
    # system("risu --config-file #{Rails.root.to_s}/risu.cfg #{engagement_file.asset.path} #{user_id} #{engagement_id}")
    
    nessus_policy = Risu::Models::Policy.where(engagement_id: engagement_id, user_id: user_id).order("id DESC").first || Risu::Models::Policy.first
    
    em = PopulateEngagementMain.new(nessus_policy, user_id, engagement_id)
    em.populate
  end
end
