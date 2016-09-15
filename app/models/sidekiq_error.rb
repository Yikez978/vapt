class SidekiqError < ActiveRecord::Base
  serialize :exception
  serialize :context_hash, Hash
end
