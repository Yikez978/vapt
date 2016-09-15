class EngagementMain < ActiveRecord::Base
  include AASM

  aasm do
    state :not_exploited, initial: true
    state :not_exploited, :working, :exploited

    event :working do
      transitions from: :not_exploited, to: :working
    end

    event :exploited do
      transitions from: [:working, :not_exploited], to: :exploited
    end
  end


  belongs_to :user
  belongs_to :engagement

  has_many :host_infos
  has_many :host_vulns
  has_many :engagement_main_users
  has_many :host_creds
  has_many :custom_findings

  has_many :notes, as: :notable

  validates_presence_of :host

  validates_format_of :host, with: /[\d{1,3}.]{4}/
  validates_format_of :vulns, with: /\d+/

  attr_accessor :exploit_status
end
