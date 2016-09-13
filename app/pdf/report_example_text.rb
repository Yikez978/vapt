class ReportExampleText
  # This class is to hold all of the "example" text to be used to show students
  # the format of what things should look like in the final report

  def self.student_name
    'John Doe'
  end

  def self.introduction
    <<-EOF
      This penetration test report contains all efforts that were conducted in order to pass the course. This report should contain all lab data in the report template format as well as all items that were used to pass the overall exam. This report will be graded from a standpoint of correctness and fullness to all aspects of the lab and exam. The purpose of this report is to ensure that the student has a full understanding of penetration testing methodologies as well as the technical knowledge to safely and professionally conduct penetration testing.
    EOF
  end

  def self.objective
    <<-EOF
      The objective of this assessment is to perform an internal penetration test against the Lab and Exam network. The student is tasked with following methodical approach in obtaining access to the objective goals. This test should simulate an actual penetration test and how you would start from beginning to end, including the overall report. An example page has already been created for you at the latter portions of this document that should give you ample information on what is expected to pass this course. Use the sample report as a guideline to get you through the reporting.
    EOF
  end

  def self.requirements
    <<-EOF
    The student will be required to fill out this penetration testing report fully and to include the following sections:
      <ul>
        <li>Overall High-Level Summary and Recommendations (non-technical)</li>
        <li>Methodology walkthrough and detailed outline of steps taken</li>
        <li>Each finding with included screenshots, walkthrough, sample code, and proof.txt if applicable.</li>
        <li>Any additional items that were not included</li>
      </ul>
    EOF
  end

  def self.high_level_summary
    <<-EOF
    John Doe was tasked with performing an internal penetration test towards the internal lab. An internal penetration test is a dedicated attack against internally connected systems. The focus of this test is to perform attacks, similar to those of a hacker and attempt to infiltrate internal lab systems – the THINC.local domain. John’s overall objective was to evaluate the network, identify systems, and exploit flaws while reporting the findings back to Lab Admin.

    When performing the internal penetration test, there were several alarming vulnerabilities that were identified on the Test network. When performing the attacks, John was able to gain access to multiple machines, primarily due to outdated patches and poor security configurations.  During the testing, John had administrative level access to multiple systems. All systems were successfully exploited and access granted. These systems as well as a brief description on how access was obtained are listed below:

    <ul>
      <li>Lab Trophy 1 – Got in through X</li>
      <li>Lab Trophy 2 – Got in through X</li>
      <li>Lab Trophy 3 – Got in through X</li>
      <li>Exam Trophy 1 – Got in through X</li>
      <li>Exam Trophy 2 – Got in through X</li>
    </ul>
    EOF
  end

  def self.recommendations
    <<-EOF
    John recommends patching the vulnerabilities identified during the testing to ensure that an attacker cannot exploit these systems in the future. One thing to remember is that these systems require frequent patching and once patched, should remain on a regular patch program to protect additional vulnerabilities that are discovered at a later date.
    EOF
  end

  def self.methodologies_overview
    <<-EOF
    John utilized a widely adopted approach to performing penetration testing that is effective in testing how well the Offensive Security Labs and Exam environments are secure. Below is a breakout of how John was able to identify and exploit the variety of systems and includes all individual vulnerabilities found.
    EOF
  end

  def self.information_gathering
    <<-EOF
    The information gathering portion of a penetration test focuses on identifying the scope of the penetration test. During this penetration test, John was tasked with exploiting the lab and exam network. The specific IP addresses were:
      Lab Network:
      192.168.1.1, 192.168.1.2

      Exam Network:
      192.168.255.1, 192.168.255.2
    EOF
  end

  def self.service_enumeration
    <<-EOF
    The service enumeration portion of a penetration test focuses on gathering information about what services are alive on a system or systems. This is valuable for an attacker as it provides detailed information on potential attack vectors into a system. Understanding what applications are running on the system gives an attacker needed information before performing the actual penetration test.  In some cases, some ports may not be listed.
    EOF
  end

  def self.enumerations
    <<-EOF
      Server: 127.0.0.1
      TCP: 80, 443
      UDP: 8080
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

  def self.maintaining_access
    <<-EOF
      Maintaining access to a system is important to us as attackers, ensuring that we can get back into a system after it has been exploited is invaluable. The maintaining access phase of the penetration test focuses on ensuring that once the focused attack has occurred (i.e. a buffer overflow), we have administrative access over the system again. Many exploits may only be exploitable once and we may never be able to get back into a system after we have already performed the exploit.
      John added administrator and root level accounts on all systems compromised. In addition to the administrative/root access, a Metasploit meterpreter service was installed on the machine to ensure that additional access could be established.
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
