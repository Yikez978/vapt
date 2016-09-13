class CveDatabase < ActiveRecord::Base
  has_many :cve_database_refs
  has_many :cve_database_votes
  has_many :cve_database_comments
  
  # Example
  # Download XML: http://cve.mitre.org/data/downloads/index.html
  # CveDatabase.populate_data_from_csv_xml("/Users/rajib/Downloads/allitems.xml")
  
  def self.populate_data_from_csv_xml(file_path)
    @doc = Nokogiri::XML(File.open(file_path))
    CveDatabase.delete_all
    CveDatabaseRef.delete_all
    CveDatabaseVote.delete_all
    CveDatabaseComment.delete_all

    @doc.xpath('//xmlns:item').each do |node|
      cve_database = CveDatabase.new
      
      # add CVE ID
      cve_database.cve_database_id = node[:name]
      
      # add status
      cve_database.status = node.search("status")[0].content rescue nil
      # add phase
      cve_database.phase = node.search("phase")[0].content rescue nil
      cve_database.phase_date = node.search("phase")[0][:date] rescue nil
      
      # add desc
      cve_database.desc = node.search("desc")[0].content rescue nil
      
      cve_database.save
      
      # add refs
      node.search("ref").each do |ref|
        ref_content = ref.content rescue nil
        ref_source = ref[:source] rescue nil
        ref_url = ref[:url] rescue nil
        
        cve_database.cve_database_refs.create(ref: ref_content, source: ref_source, url: ref_url)
      end
      
      # add votes
      unless node.search("votes").empty?
        node.search("votes").children.each do |vote|
          if vote.element?
            vote_content = vote.content rescue nil
            vote_count = vote[:count] rescue nil
            vote_type = vote.name rescue nil
          
            cve_database.cve_database_votes.create(vote: vote_content, count: vote_count, vote_type: vote_type)
          end
        end
      end
      
      # add comment
      node.search("comment").each do |comment|
        comment_content = comment.content rescue nil
        comment_voter = comment[:voter] rescue nil
        
        cve_database.cve_database_comments.create(comment: comment_content, voter: comment_voter)
      end
        
    end
  end
end
