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
 1. Auto Vulnerability coloration from Nessus scan, Test Plan, to Nist controls.
 2. Auto syncing tools from interface.

How to deploy from scratch.
===========================

<H6>
NOTE: This is not a secure configuration and should only be used in development. NOT PRODUCTION!
</H6>

##

1. Download CentOS 7 ISO Minimal 
http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso

2. Open up VMware
1. Select Typical(Recommended) 
2. Then click Next.
![](http://i.imgur.com/ka6q5pN.png)
1. Select Install disk Image from ISO. 
2. Browes to your CentOS ISO image. 
3. Then Click next.
![](http://i.imgur.com/GOjA5zh.png)
1. Enter Full name: Dev.
2. Enter Username: dev
3. Enter password: vapt
4. Enter Confirm: vapt
![](http://i.imgur.com/xbHkLv8.png)
1. Virtual Machine name: vapt
2. Click Next
![](http://i.imgur.com/xR6tdih.png)

You can leave the default settings on the next this screen.
===========================

1. Maximum Disk Size: 20
2. Split virtual disk into multiple files.
3. Click next
![](http://i.imgur.com/PETJigx.png)
1. Click Customize Hardware
![](http://i.imgur.com/Tu7qUSS.png)

You will be configuring the memory, Processors and Network Adaptor
===========================

This is the default view
![](http://i.imgur.com/okAazV5.png)
1. Slide the memory slider to 2 gigs or higher.(I use a 4 gigs)
![](http://i.imgur.com/K6lbPJm.png)
Next click Processors
1. Number of processors: Select 2
2. Number of cores per processors: Select 2
![](http://i.imgur.com/8yc8JJg.png)
Next Click Network Adaptor
1. On the left select Bridged
2. Then select Replicate physical network connection state
3. Click Close
![](http://i.imgur.com/xv8Bzel.png)
This is what your end configuration should look like.
1. Click Finish
![](http://i.imgur.com/QrH2jvL.png)
---------------------------------------
The virtual machine will now go through its startup process. It will take you to the following screen when it is done.
You should now see the "Welcome to CenOS 7 Screen"
1. Default should be English
2. Click Continue
![](http://i.imgur.com/qDXkVyP.png)

1.0This is the next setup screen. You will be using the following configurations.
===========================

1. Disable KDump
2. Disable all Security Profiles
3. Installation Destination
4. Network Settings
![](http://i.imgur.com/XIynkJW.png)

1.1 KDump
===========================

1. Disable Kdump by removing the Check mark next to "Enable kdump"
2. Click Done
![](http://i.imgur.com/65uSf7c.png)

1.2 Security Policy
===========================

1. Move Security policy slider from "On" to "Off"
2. Click Done
![](http://i.imgur.com/b19xzcX.png)

1.3 Insulation Destination
===========================

1. Just click Done
![](http://i.imgur.com/PNJC1YL.png)

1.4 Network & Hostname
===========================

1. Move the slider from "Off" to "On"
- Ensure your IP address is the correct address!
2. Click Done
![](http://i.imgur.com/wnIDNYO.png)
Click Begin Installation
![](http://i.imgur.com/BUh8b3D.png)
-----------------------------------------------------

2.0 User settings creation screen/
===========================

1. Create Root Password:
2. Create User:
![](http://i.imgur.com/4Yc5d95.png)

2.1 Select Root Password
===========================

![](http://i.imgur.com/apXaoMu.png)
1. Root Password: vapt
2. Confirm: vapt
3. Click Done

2.2 Click User Creation
===========================

1. Full Name: vapt
2. User name: vapt
3. Check the "Make this user administrator" box.
4. Password: vapt
5. Confirm Pasword: vapt
6. Click Done
![](http://i.imgur.com/NjsxJkl.png)

When the install and setup is complete click the "Reboot" button.
1. Click Reboot
![](http://i.imgur.com/VZLll2c.png)

3.0 Install Complete. SSH & configure Environment
===========================
 ![](http://i.imgur.com/Vva0Ma0.png)

3.1 Download MobaXterm or your favorite SSH program.
===========================

- If you have one then skip this part.
I personally use MobaXterm on windows(http://mobaxterm.mobatek.net/)
------------------------------------------------
4.0 Install Git
===========================

```bash
sudo yum install git -y
```
```bash
password for vapt: vapt 
```
![](http://i.imgur.com/TtB6Y1B.png)

5.0 Git Clone Repo
 ===========================
 
(https://github.com/anpseftis/vapt.git)

##6.0 Run deploy.sh script
1. This will take you to the vapt directory.
```bash
cd vapt/
```
2. This will list whats in the directory.
```bash
ls
```
![](http://i.imgur.com/rlcgs2C.png)
```bash
sudo ./deploy.sh
```
Enter password: vapt

<H3>Sit Back Drink Coffee. This will take 45 mins to completely build and deploy.</h3>