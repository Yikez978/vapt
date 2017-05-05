class Report < ActiveRecord::Base
  has_many :hosts
  belongs_to :policy

  class << self

    serialize :options, Hash
    has_many :hosts
    belongs_to :policy
    belongs_to :user
    belongs_to :customer
    belongs_to :engagement
    has_many :screenshots, dependent: :destroy
    accepts_nested_attributes_for :screenshots, :title, :author, :company, :classification, :network, :owner, :location, :extra

    #
    #@scan_date = Host.where("start is not null").first[:start].to_s
    #
    def scan_date
      Host.where("start IS NOT NULL").first[:start]
    end

    def self.severity_levels
      {
          'CRITICAL' => :critical,
          'HIGH' => :high,
          'MEDIUM' => :medium,
          'LOW' => :low,
          'NOTE' => :note
      }
    end
    #
    # @TODO comment this / rewrite this
    #
    def scanner_nessus_ratings_text
      text = "The vulnerability scanner used by #{Report.company} rates the findings as follows: Critical, High, Medium, Low and Informational. Critical findings represent a security hole, this is the highest rating a risk can get.  These generally represent vulnerabilities that can lead to full system compromise due to missing security patches. Critical findings should be re-mediated first as they generally leave the network wide open. High findings are slightly less severe than Critical findings but the severity depends on the calculated CVSS base score. Medium findings are considered a security warning; these are not as severe as high but should be evaluated on a risk-by-risk basis. These are typically configuration errors that can lead to information disclosures such as usernames, passwords, and configuration settings. Low findings are identified as security notes; these provide information the scanner discovered during the scanning process. The information includes items such as hostname, domain name, and MAC address. Open Port findings represent the open ports on each system that the scanner found during the scan process. These should be evaluated against firewall settings to test the firewall configurations.\n\n"
      text << "After the scanner is complete, the scanner evaluates each finding and bases it on the Common Vulnerability Scoring System (CVSS) score assigned to each finding. Any findings with a CVSS base score of 10 are upgraded to a Critical finding. These represent vulnerabilities that are trivial to gain administrator access to the system, with little to no effort. For more information on the CVSS scoring system please visit: http://nvd.nist.gov/cvss.cfm.\n\n"

      return text
    end
  end
end


