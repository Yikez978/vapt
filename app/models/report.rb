class Report < ActiveRecord::Base

  serialize :options, Hash

  belongs_to :user
  belongs_to :customer

  belongs_to :engagement

  has_many :screenshots, dependent: :destroy
  accepts_nested_attributes_for :screenshots

  def self.severity_levels
    {
        'CRITICAL' => :critical,
        'HIGH' => :high,
        'MEDIUM' => :medium,
        'LOW' => :low,
        'NOTE' => :note
    }
  end
end