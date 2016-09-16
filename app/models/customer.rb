class Customer < ActiveRecord::Base
  validates :name, presence: true
  has_many :engagements
  has_many :reports

  def to_s
    name
  end
end
