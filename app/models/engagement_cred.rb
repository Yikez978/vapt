class EngagementCred < ActiveRecord::Base
  belongs_to :user
  belongs_to :engagement
  
  validates_presence_of :ip
  validates_presence_of :pwdump
  validates_presence_of :password
  validates_presence_of :description

  def self.as_csv
  	CSV.generate do |csv|
	    csv << column_names
	    all.each do |item|
	      csv << item.attributes.values_at(*column_names)
	    end
  	end
	end
end
