class SubEngagement < ActiveRecord::Base
	belongs_to :engagement

	has_many :pocs
	has_many :system_admins
	has_many :ips

	attr_accessor :poc, :system_admin, :ip

	def self.create_new(sub_engagement_param, engagement)
		sub_engagement = Engagement.new
		sub_engagement.engagement_name = sub_engagement_param['sub_engagement_name']
		sub_engagement.engagement_type_id = engagement.engagement_type_id
		sub_engagement.start_date = engagement.start_date
		sub_engagement.end_date = engagement.end_date
		sub_engagement.user_id = engagement.user_id
		sub_engagement.aasm_state = engagement.aasm_state
		sub_engagement.ocb_number = engagement.ocb_number
		sub_engagement.ocb_start_date = engagement.ocb_start_date
		sub_engagement.ancestry = engagement.id
		sub_engagement.save(validate: false)
    
    # add Ips to sub engagement
    sub_engagement_ips_from_parms = sub_engagement_param['ip'].split(',')
    sub_engagement_ips_from_parms.each do |ip_address|
      sub_engagement.ips.create(ip: ip_address)
    end
    
    # add Pocs to sub engagement
    sub_engagement_pocs_from_parms = sub_engagement_param['poc'].split(',')
    sub_engagement_pocs_from_parms.each do |poc|
      sub_engagement.pocs.create(name: poc)
    end
    
    # add System admins to sub engagement
    sub_engagement_system_admins_from_parms = sub_engagement_param['system_admin'].split(',')
    sub_engagement_system_admins_from_parms.each do |system_admin|
      sub_engagement.system_admins.create(name: system_admin)
    end
	end
end


#  {"sub_engagement_name"=>"sub eng of 13 #2", "ip"=>"192.168.0.3", "poc"=>"ujjal", "system_admin"=>"rajib", "_destroy"=>"false"}