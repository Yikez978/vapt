class User < ActiveRecord::Base
	include SettingsHelper
	attr_accessor :remember_token, :reset_token
	belongs_to :team

	has_many :reports, dependent: :destroy
	has_many :exploits, dependent: :destroy
	has_many :nmap_reports, dependent: :destroy
	has_many :notes, dependent: :destroy
  has_many :metasploit_reports, dependent: :destroy

	has_many :user_engagements
	has_many :engagements, through: :user_engagements

	has_many :user_engagements
	has_many :engagements, through: :user_engagements
  has_many :user_created_engagements, class_name: 'Engagement'

  has_many :system_admins
  has_many :pocs

	validates :fname,  presence: true, length: { maximum: 50 }
	validates :lname,  presence: true, length: { maximum: 50 }
	validates :username, presence: true, length: { maximum: 128 },
											 uniqueness: {case_sensitive: true}
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	#validates :email, presence: true, length: { maximum: 255 },
	#									format: { with: VALID_EMAIL_REGEX },
	#									uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum:6 }, allow_nil: true
	has_attached_file :avatar, styles: { thumb: "80x80", medium: "200x200" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  scope :all_except_current_user, ->(id) {where.not(id: id)}

	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def is_member?(team)
		self.team.id == team.id
	end

	def leave_team
		update_attribute(:team_id, nil)
	end

	def join_team(team)
		self.team = team
		self.save
	end

	def remember
		self.remember_token = User.new_token
		update_attribute :remember_digest, User.digest(remember_token)
	end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute :remember_digest, nil
	end

	def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

	def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def full_name
    get_full_name
  end

	def get_full_name
		return self.fname + " "+  self.lname
	end

	private

end
