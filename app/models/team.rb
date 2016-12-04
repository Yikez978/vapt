class ValidateAtCapacity < ActiveModel::Validator

  def validate(record)
    if record.at_capacity?
      record.errors[:capacity] << 'Team has reached capcity'
    end
  end
end

class Team < ActiveRecord::Base
	include ActiveModel::Validations
	include SettingsHelper
	has_many :users, dependent: :destroy, inverse_of: :team
	validates :name,  presence: true, length: { maximum: 50 },
										uniqueness: true
	validates :passphrase,  presence: true, 
													length: { minimum: 15 }
	validates_with ValidateAtCapacity

	end
