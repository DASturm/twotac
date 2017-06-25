#!/bin/bash
$FILES= "/opt/bin/ /var/www/html/ /etc/tacacs+/tac_plus.conf /etc/pam.d/tac_plus /etc/postfix/main.cf"
source tac.conf
trap '' 2
while true
do
clear
echo "========================================================================================="
echo "                                    Twotac Management                                    "
echo "========================================================================================="
echo " Available commands:"
echo " To edit the organization name,     enter 1"
echo " To edit the website's hostname,    enter 2"
echo " To edit the admin's mail address,  enter 3"
echo " To configure your SMTP relay host, enter 4"
echo " To configure your TACACS+ key,     enter 5"
echo " To view changes made so far,       enter V"
echo " To commit changes to memory,       enter C"
echo " To exit,                           enter Q"
echo -e "\n"
echo " **NOTE: IF YOU DO NOT COMMIT, CHANGES WILL NOT BE SAVED**"
echo -e "\n"
echo "====================================================="
echo -e "Enter your selection"
echo "====================================================="
echo -e "\n\c"
read answer
echo -e "\n"
case $answer in
	1) echo "========================================================================================="
			echo -e " Currently, the organization name is $ORG \nWhat would you like to change it to?"
			read NEWORG 
			read -p "Press enter to continue" 
			echo -e "" 
				;;
	2) echo "========================================================================================="
			echo -e " Currently, the website's hostname is $WEB \nWhat would you like to change it to?"
			echo -e " NOTE: If you would like to make this site https, include it in the hostname"
			read NEWWEB 
			echo -e " Press 'Enter' to continue \c" 
			echo -e "" 
				;;
	3) echo "========================================================================================="
			echo -e " Currently, the admin's mail address is $MAIL \nWhat would you like to change it to?"
			read NEWMAIL
			echo -e " Press 'Enter' to continue \c" 
			echo -e "" 
				;;
	4) echo "========================================================================================="
			echo -e " Currently, the SMTP host is $SMTP \nWhat would you like to change it to?"
			read NEWSMTP
			echo -e " Press 'Enter' to continue \c" 
			echo -e "" 
				;;
	5) echo "========================================================================================="
			echo -e " Currently, the TACACS+ key is $KEY \nWhat would you like to change it to?"
			echo -e " ***WARNING, YOU WILL NEED TO CHANGE ALL ROUTER CONFIGS TO MATCH THE NEW ONE***"
			read NEWKEY
			echo -e " Press 'Enter' to continue \c" 
			echo -e "" 
				;;
	V) clear
			echo "====================================================="
			echo "                   Current Changes                   "
			echo "====================================================="
			echo " Original    ::::    New"
			echo -e " $ORG    ::::    $NEWORG"
			echo -e " $WEB    ::::    $NEWWEB"
			echo -e " $MAIL    ::::    $NEWMAIL"
			echo -e " $SMTP    ::::    $NEWSMTP"
			echo -e " $KEY    ::::    $NEWKEY"
			echo "====================================================="
			echo -e " Press 'Enter' to continue \c" 
				;;
	C) echo -e "Are you certain you want to commit these changes? There will be no way to undo them. (yes/no) \c"
			find -type f -name '$FILES' | xargs sed -i 's/$ORG/$NEWORG/g'
			find -type f -name '$FILES' | xargs sed -i 's/$WEB/$NEWWEB/g'
			find -type f -name '$FILES' | xargs sed -i 's/$MAIL/$NEWMAIL/g'
			find -type f -name '$FILES' | xargs sed -i 's/$SMTP/$NEWSMTP/g'
			find -type f -name '$FILES' | xargs sed -i 's/$KEY/$NEWKEY/g'
			;;
	Q) exit 
			;;
esac
done