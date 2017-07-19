# twotac
Two-factor router and switch authentication with an open platform and a simple set of management scripts.

## Overview
At its most basic, the average network device uses a local login system. All too often, security systems rely on one known username and password. TACACS+ is a major improvement; users can be managed individually from the local UNIX machine, and logging, requests and other information become more descriptive as TACACS+ becomes the primary method of logging in, thereby making it easier to detect security breaches and other suspicious activity. TACACS+ has one more advantage, that it can be redirected to and through other systems, such as Google's two-factor authenticator. Twotac embraces this, combining a number of other ubuntu applications to make for a fully functional AAA authentication server that is easy to set up and run. Twotac comes fully equipped with a web registration interface, a mailer system, its own logging and backup scripts, and a user registration script which automates the process.
README in progress!

## Prerequisites
Twotac is dependent on a number of important applications, and not just TACACS+. To install this software, you will need:
TACACS+
PAM
google-authenticator
apache2
postfix

## Installation
To install Twotac (in its current state) please run:
```bash
$ git clone https://github.com/dsturm-l/twotac.git
$ dpkg-deb -b twotac/
$ dpkg -i twotac.deb
```
If there are missing dependencies, please run:
```bash
$ sudo apt-get install -f
```
If twotac was not installed by dpkg due to missing dependencies, rerun the dpkg -i command.
README in progress!

## Twotac Setup
To set up the twotac system according to your own organization and administrators, please run:
```bash
$ /opt/bin/tacmanager
```
Tacmanager is a simple, menu-based system that should help configure, run and read out information on the system.
If you haven't run tacmanager yet, it will try to run a first-time setup. Let it. It will ask for important information, such as your organization name, the e-mail address of your administrator, your registration website's domain name, an SMTP address usable by the host server, and most importantly, your TACACS+ key. It will also try to overwrite your existing configurations for postfix, PAM, and TACACS+. After it's done this, it will combine the new default scripts and your submitted information about your company to rewrite the included scripts and content to your personalization.

## Additional Setup
Just because twotac is designed to run with a website, SMTP relay and TACACS+ does not mean you can run twotac's installation and have a AAA authentication server running immediately. There is still much work to be done on the administrator's end. The hostname will need a DNS reservation. The host server will need a static IP address from DHCP so the network devices on AAA can access the server reliably. There ought to be a functional SMTP server if the administrators plan on using the mail system or the web interfaces. And lastly, this software does not actually configure your network devices. 
README in progress!

## Software and Scripts
Twotac utilizes a number of scripts to automate and simplify the TACACS+ and google-authenticator registration process.
/opt/bin/tacmanager -- README in progress!
/opt/bin/tacuser -- README in progress!
/opt/bin/tacdelete -- README in progress!
/etc/cron.weekly/backup.sh -- README in progress!
/etc/cron.weekly/taclogrotate.sh -- README in progress!

## Other Components
README in progress!
