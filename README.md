Vulnerability Assessment Penitration Tool (VAPT)
================================================

This is a framework built for penters and teams to collect and corrilate data during a penitration test.  VAPT has the following capabilities:
- User Registration
- Project Scheduling
- Tool parsing
  - Nmap
  - Nessus
  - Metasploit DB
- Report retention and security
- Local Datase Mapping
  - National Vulnerability Database (NVD)
    *Note: Custom user created exploites can be added to your local database through the gui.
  - Common Vulnerabilities and Exposures (CVE)
  - Common Weakness Enumeration (CWE)
  
Features that will be added
===========================
1. NIST 800-53 DB gui with search :status Complete - will be released in next major update
2. NIST 800-60 DB gui with search :status Complete - will be released in next major update
3. Vulnerability mapping to NIST controls :Working


How to deploy from scratch.
===========================
1. Download CentOS 7 ISO Minimal 
http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso

2. Open up VMware
![Open VMWare](https://github.com/anpseftis/vapt/README/1.png)
- Create user: dev
- Password: vapt
- Turn off security profiles
- Finish install
3. login to vm as root
- choduser -aG wheel dev
- logout
- Login as dev
4. Copy deploy.sh script into vm.
- chmod +x deploy.sh
5. Run deploy.sh
- ./deploy.sh
  
Congrats you have successfully setup VAPT!
 


