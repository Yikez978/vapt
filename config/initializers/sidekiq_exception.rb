# Sidekiq exception handling
Sidekiq.configure_server do |config|
  config.error_handlers << Proc.new {|ex,ctx_hash| SidekiqErrorService.notify(ex, ctx_hash) }
  
  Rails.logger.info "=========================================================================="
  Rails.logger.info "Sidekiq initializer"
  Rails.logger.info "=========================================================================="
end