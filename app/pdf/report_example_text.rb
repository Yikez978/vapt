class ReportExampleText

  def self.student_name
    'Testers Name'
  end

  def self.introduction
    <<-EOF
      This report represents a security audit performed by the Cyber Security Group(CSG). It contains confidential information about the state of your network. Access to this information by unauthorized personnel may allow them to compromise your network.
    EOF
  end

  def self.objective
    <<-EOF
      The objective of this assessment is what is stated in the statement of work(SOW).
    EOF
  end

  def self.requirements
    <<-EOF
    The requirements should mirror what is on the statement of work(SOW).
    EOF
  end

  def self.high_level_summary
    <<-EOF
    CSG was contracted by [Customers Name] to conduct a penetration test in order to
    determine its exposure to a targeted attack. All activities were conducted in a manner that simulated a
    malicious actor engaged in a targeted attack against [System Name] with the goals of:
    o Identifying if a remote attacker could penetrate MegaCorp One’s defenses
    o Determining the impact of a security breach on:
    o Confidentiality of the company’s private data
    o Internal infrastructure and availability of [Customers Name] information systems

    Efforts were placed on the identification and exploitation of security weaknesses that could allow a
    remote attacker to gain unauthorized access to organizational data. The attacks were conducted with
    the level of access that a general Internet user would have. The assessment was conducted in
    accordance with the recommendations outlined in NIST SP 800-1151 with all tests and actions being
    conducted under controlled conditions
    EOF
  end

  def self.recommendations
    <<-EOF
    Due to the impact to the overall organization as uncovered by this penetration test, appropriate
    resources should be allocated to ensure that remediation efforts are accomplished in a timely manner.
    While a comprehensive list of items that should be implemented is beyond the scope of this engagement, some high level items are important to mention.
    CSG recommends the following:
    EOF
  end

  def self.risk_rating
    <<-EOF
    The overall risk identified to [Customers Name] as a result of the penetration test is High. A direct path from
    external attacker to full system compromise was discovered. It is reasonable to believe that a malicious
    entity would be able to successfully execute an attack against [Customers Name] through targeted attacks.
    EOF
  end

  def self.information_gathering
    <<-EOF
    Information gathering and information assessment are the foundations of a good penetration test. The more informed the tester is about the environment, the better the results of the test will be. In this section, a number of items should be written up to show the CLIENT the extent of public and private information available through the execution of the Information gathering phase
    EOF
  end

  def self.penetrations
    <<-EOF
      Vulnerability Exploited:  Ability Server 2.34 FTP STOR Buffer Overflow

      System Vulnerable: 172.16.203.134

      Vulnerability Explanation: Ability Server 2.34 is subject to a buffer overflow vulnerability in STOR field. Attackers can use this vulnerability to cause arbitrary remote code execution and take completely control over the system. When performing the penetration test, John noticed an outdated version of Ability Server running from the service enumeration phase. In addition, the operating system was different from the known public exploit. A rewritten exploit was needed in order for successful code execution to occur. Once the exploit was rewritten, a targeted attack was performed on the system which gave John full administrative access over the system.

      Vulnerability Fix: The publishers of the Ability Server have issued a patch to fix this known issue. It can be found here: http://www.code-crafters.com/abilityserver/

      Severity: Critical

      Proof of Concept Code Here:  Modifications to the existing exploit was needed and is highlighted in red. [Screenshots attached]
    EOF
  end

  def self.post_exploitation
    <<-EOF
      One of the most critical items in all testing is the connection to ACTUAL impact on the CLIENT being tested. While the sections above relay the technical nature of the vulnerability and the ability to successfully take advantage of the flaw, the Post Exploitation section should tie the ability of exploitation to the actual risk to the business.
    EOF
  end

  def self.house_cleaning
    <<-EOF
      The house cleaning portions of the assessment ensures that remnants of the penetration test are removed. Often fragments of tools or user accounts are left on an organizations computer which can cause security issues down the road. Ensuring that we are meticulous and no remnants of our penetration test are left over is important.
      After the trophies on both the lab network and exam network were completed, John removed all user accounts and passwords as well as the Meterpreter services installed on the system.
    EOF
  end

  def self.additional_items
    <<-EOF
    This section is placed for any additional items that were not mentioned in the overall report.
    EOF
  end

  def self.method_missing(arg)
    'This is exmaple text.'
  end
end
