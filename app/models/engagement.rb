class Engagement < ActiveRecord::Base
  include AASM

  aasm do
    state :pending, initial: true
    state :pending, :active, :on_hold, :completed, :canceled

    event :activate do
      transitions from: [:active, :on_hold, :pending], to: :active
    end

    event :hold do
      transitions from: :active, to: :on_hold
    end

    event :ended do
      transitions from: [:active, :pending], to: :completed
    end

    event :canceled do
      transitions from: :pending, to: :canceled
    end
  end

  belongs_to :customer
  has_many :ips
  has_many :pocs
  has_many :hosts
  has_many :system_admins
  has_many :ocbs
  has_many :sub_engagements
  has_many :notes, as: :notable
  has_many :nmap_reports
  has_many :nessus_policies, class_name: 'Risu::Models::Policy'
  has_many :nessus_reports, class_name: 'Risu::Models::NessusReport'

  has_many :nessus_plugins, class_name: 'Risu::Models::Plugin'
  has_many :nessus_hosts, class_name: 'Risu::Models::Host'
  has_many :engagement_mains
  has_many :engagement_creds
  has_many :engagement_files
  has_many :metasploit_reports

  has_many :user_engagements
  has_many :users, through: :user_engagements

  has_many :reports

  default_scope { order(:created_at => :desc) }

  accepts_nested_attributes_for :ips, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pocs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :hosts, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :system_admins, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :ocbs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :sub_engagements, allow_destroy: true

  has_many :children, class_name: 'Engagement'
  # accepts_nested_attributes_for :children, allow_destroy: true

  belongs_to :engagement_type
  belongs_to :engagement_status
  belongs_to :user

  attr_accessor :poc, :system_admin, :ocb_number, :ip, :ocb_start_date

  validates_presence_of :customer, on: :create
  validates_presence_of :engagement_name
  validates_presence_of :start_date
  validates_presence_of :end_date

  validates_presence_of :ocb_number, on: :create
  validates_presence_of :ocb_start_date, on: :create

  validate :unique_ocb_number

  scope :find_all_except_canceled, -> {where.not(aasm_state: :canceled) }
  scope :where_pending, -> {where(aasm_state: :pending)}
  has_ancestry


  def self.change_engagements_status
    where_pending.each do |engagement|
      # Skip if already Completed
      unless engagement.completed?
          # Check if started & active
        if engagement.start_date <= Date.today
          engagement.activate
        end
      end

      engagement.save

    end
  end

  def created_by?(current_user)
    (user == current_user) ? true : false
  end

  def active_ocb
    ocbs.try(:first)
  end

  def sub_engagement?
    self.ancestry ? true : false
  end

  private

  def unique_ocb_number
    if Ocb.pluck(:number).include? self.ocb_number
      errors.add(:base, "ocb number has to be unique")
    end
  end
end
