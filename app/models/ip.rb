class Ip < ActiveRecord::Base
  belongs_to :engagement
  belongs_to :sub_engagement

  class << self
    def create_new(file_content, engagement_id, sub_engagement_id=nil)
      ip_array = []

      if file_content.include? ","

        #If the content is like 1.1.1.1/24 , 2.1.1.1/24
        if file_content.include? "/"
          ips = file_content.delete(" ").split(",")
          ips.each do |ip_string|
            ip_range = IPAddr.new(ip_string).to_range()
            ip_range.each do |ip|
              ip_array << ip.to_s
            end
          end

        #if the content is like 1.1.1.1-24 , 2.1.1.1-24
        elsif file_content.include? "-"
          ips = file_content.delete(" ").split(",")
          ips.each do |ip_string|
            content_split(ip_string , ip_array)
          end
        else

          #If the content is like 1.1.1.1 , 1.1.1.2
          ip_array = file_content.delete(" ").split(",")
        end
      elsif file_content.include? "\n"
				
        #if the content is like 1.1.1.1/24 \n 2.1.1.1/24
        if file_content.include? "/"
          ips = file_content.split("\n")
          ips.each do |ip_string|
            ip_range = IPAddr.new(ip_string).to_range()
            ip_range.each do |ip|
              ip_array << ip.to_s
            end
          end
					
        #if the content is like 1.1.1.1-24 \n 2.1.1.1-24
        elsif file_content.include? "-"
          ips = file_content.split("\n")
          ips.each do |ip_string|
            content_split(ip_string , ip_array)
          end

        #if the content is like 1.1.1.1 \n 1.1.1.2
        else
          ip_array = file_content.split("\n")
        end

      #if the content is like 1.1.1.1/24
      elsif file_content.include? "/"
        ip_range = IPAddr.new(file_content).to_range()
        ip_range.each do |ip|
          ip_array << ip.to_s
        end
			
      #if the content is like 1.1.1.1-24
      elsif file_content.include? "-"
        content_split(ip_string , ip_array)
      else
        # if single ip supplied 192.168.0.1
        ip_array << file_content
      end
      
      ip_array.map do |name|
        Ip.create(ip: name, engagement_id: engagement_id)
      end
    end

    private

    def content_split(ip_string , ip_array)
      ip_addr_array = ip_string.split("-")
      ip_addr = ip_addr_array[0]
      loop_count = ip_addr_array[1].to_i
      ip_s = ip_addr.split('.')
      count = ip_s.pop.to_i
      ip_i = ip_s.join('.')+'.'
      for i in 1..loop_count
        ip_array << ip_i + i.to_s
      end
    end
  end
end
