This is a partially working demo of our VAPT Framework and its capabilities. 

Full Development of this project is underway by  Jacobs Engineering Group (JCE) & The Jacobs Cyber Security Group(CSG)

The [JCE](http://invest.jacobs.com/investors/Press-Release-Details/2017/Jacobs-Unveils-Connected-Enterprise-Framework-to-Enable-Digital-Transformation/default.aspx) provides clients the capability to connect, protect and analyze operational systems and data.
Lean More about @ [JCE](http://invest.jacobs.com/investors/Press-Release-Details/2017/Jacobs-Unveils-Connected-Enterprise-Framework-to-Enable-Digital-Transformation/default.aspx)

Vulnerability Assessment Penetration Tool (VAPT) 
================================================

This is a framework built for pen-testers and teams to collect and correlate data during a penetration test. VAPT has the following capabilities:
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
 3. Data Analytics
 4. RMF validation / customization

Getting Ready to deploy?
===========================
1. VAPT currently runs on CentOS 7 Minimal install
2. Our instructions use VMWARE to deploy but you can use other deployment methods.
3. We have deployed this on Mac OSX. You will just need to download the correct packages.

How to deploy from scratch.
===========================

<H6>NOTE: This is not a secure configuration and should only be used in development. NOT PRODUCTION!

##

1. Download CentOS 7 ISO Minimal 
click to download: [CENTOS 7](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso)

2. Open up VMware
1. Select Typical(Recommended) 
2. Then click Next.
##

![](http://i.imgur.com/ka6q5pN.png)

##
<h4> Starting page

1. Select Install disk Image from ISO. 
2. Browse to your CentOS ISO image. 
3. Then Click next.

![](http://i.imgur.com/GOjA5zh.png)

##
<h4> Create user

1. Enter Full name: Dev.
2. Enter Username: dev
3. Enter password: vapt
4. Enter Confirm: vapt

![](http://i.imgur.com/N4KBYBl.png)

##
<h4> Name VM

1. Virtual Machine name: vapt
2. Click Next

![](http://i.imgur.com/xR6tdih.png)

##

<h4>Disk Settings - Leave Default

1. Maximum Disk Size: 20
2. Split virtual disk into multiple files.
3. Click next

##

![](http://i.imgur.com/PETJigx.png)

##

<h4>Click Customize Hardware

![](http://i.imgur.com/Tu7qUSS.png)

##

Main Configure Page
===========================

<h4>This is the default view
##

![](http://i.imgur.com/okAazV5.png)
1. Slide the memory slider to 2 gigs or higher.(I use a 4 gigs)

##

![](http://i.imgur.com/K6lbPJm.png)

<h4>Next click Processors
1. Number of processors: Select 2
2. Number of cores per processors: Select 2

![](http://i.imgur.com/8yc8JJg.png)

##

<h4>Next Click Network Adaptor
1. On the left select Bridged
2. Then select Replicate physical network connection state
3. Click Close

##

![](http://i.imgur.com/xv8Bzel.png)

<h4>This is what your end configuration should look like.
1. Click Finish

![](http://i.imgur.com/QrH2jvL.png)

##

<H6>The virtual machine will now go through its startup process. 

<H6>It will take you to the following screen when it is done.

<H6>You should now see the "Welcome to CenOS 7 Screen"

##

<H4>Language
1. Default should be English
2. Click Continue

![](http://i.imgur.com/qDXkVyP.png)

##

1.0 - Configurations cont.
===========================

![](http://i.imgur.com/XIynkJW.png)

##

<h4>Main Screen
1. Disable KDump
2. Disable all Security Profiles
3. Installation Destination
4. Network Settings

##

1.1 - KDump
===========================

1. Disable Kdump by removing the Check mark next to "Enable kdump"
2. Click Done

![](http://i.imgur.com/65uSf7c.png)

##

1.2 - Security Policy
===========================
1. Move Security policy slider from "On" to "Off"
2. Click Done

![](http://i.imgur.com/b19xzcX.png)

##

1.3 - Insulation Destination
===========================

1. Just click Done

![](http://i.imgur.com/PNJC1YL.png)

##

1.4 - Network & Hostname
===========================

1. Move the slider from "Off" to "On"
2. Click Done

![](http://i.imgur.com/wnIDNYO.png)

Click Begin Installation

![](http://i.imgur.com/BUh8b3D.png)

2.0 - User settings creation screen/
===========================
1. Create Root Password:
2. Create User:

![](http://i.imgur.com/4Yc5d95.png)

##

2.1 Select Root Password
===========================

![](http://i.imgur.com/apXaoMu.png)

1. Root Password: vapt
2. Confirm: vapt
3. Click Done

##

2.2 Click User Creation
===========================

1. Full Name: vapt
2. User name: vapt
3. Check the "Make this user administrator" box.
4. Password: vapt
5. Confirm Pasword: vapt
6. Click Done

![](http://i.imgur.com/NjsxJkl.png)

<H6>When the install and setup is complete click the "Reboot" button.
1. Click Reboot

![](http://i.imgur.com/VZLll2c.png)

3.0 Install Complete. SSH & configure Environment
===========================

 ![](http://i.imgur.com/Vva0Ma0.png)
 
##

3.1 Download MobaXterm
===========================

<H6>If you have one then skip this part.
I personally use MobaXterm on windows
(http://mobaxterm.mobatek.net/)

##

4.0 Install Git
===========================

```bash
yum install git -y
```
```bash
password for root: vapt 
```

![](http://i.imgur.com/v4wmpE1.png)

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

![](http://i.imgur.com/Q3r4jpf.png)

```bash
./deploy.sh
```

```bash
Enter password: vapt
```

##

<h4>Sit back and Drink Coffee! This will take 45 mins or so depending on your setup.

##

![](http://68.media.tumblr.com/bd42af65d080509c63e539d589d05fcc/tumblr_o19fboIpq51tzebzdo1_500.png)

##

## Contributors

This program was developed by Angelis Pseftis
