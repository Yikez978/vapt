class Team < ActiveRecord::Base
	include SettingsHelper
	has_many :users, dependent: :destroy, inverse_of: :team
	validates :name,  presence: true, length: { maximum: 50 },
										uniqueness: true
end
