# app/services/sidekiq_error_service.rb
class SidekiqErrorService
  def self.notify(exception, context_hash)
    SidekiqError.create(exception: exception, context_hash: context_hash)
  end
end