#!/bin/bash
#Files variable may need work and may need to automatically gather file names/paths from a function
FILES="/opt/bin/* /var/www/html/* /etc/tacacs+/tac_plus.conf /etc/pam.d/tac_plus /etc/postfix/main.cf"
#This is where the current variables will be stored
source tac.conf
trap '' 2
while true
do
clear
echo "========================================================================================="
echo "                                    Twotac Management                                    "
echo "========================================================================================="
echo " Available commands:"
echo " For a quick edit to all variables, enter A"
echo " To edit the organization name,     enter 1"
echo " To edit the website's hostname,    enter 2"
echo " To edit the admin's mail address,  enter 3"
echo " To configure your SMTP relay host, enter 4"
echo " To configure your TACACS+ key,     enter 5"
echo " To view changes made so far,       enter V"
echo " To commit changes to memory,       enter C"
echo " To exit,                           enter Q"
echo -e ""
echo " **NOTE: IF YOU DO NOT COMMIT, CHANGES WILL NOT BE SAVED**"
echo -e ""
echo "====================================================="
echo -e "Enter your selection"
echo "====================================================="
echo -e "\n"
read answer
case $answer in
	[Aa] ) 	echo "========================================================================================="
			echo "                                    Organization Name                                    "
			echo "========================================================================================="
			echo -e " Currently, the organization name is $ORG \n What would you like to change it to?"
#Test $newvar if true then show $newvar before prompt
				if [ $NEWORG ]; then
					echo -e "The current replacement is $NEWORG"
				fi
			read NEWORG
			echo -e "\n"
			echo "$NEWORG will be your new organization name"
			read -p "Press enter to continue"
			echo -e "\n"
			echo "========================================================================================="
			echo "                                      Web Host Name                                      "
			echo "========================================================================================="
			echo -e " Currently, the website's hostname is $WEB \n What would you like to change it to?"
			echo -e " NOTE: If you would like to make this site https, include it in the hostname"
				if [ $NEWWEB ]; then
					echo -e "The current replacement is $NEWWEB"
				fi
			read NEWWEB
			echo -e "\n"
			echo "$NEWWEB will be your new host address"
			read -p "Press enter to continue"
			echo -e "\n"
			echo "========================================================================================="
			echo "                                   Administrator Mail                                    "
			echo "========================================================================================="
			echo -e " Currently, the admin's mail address is $MAIL \n What would you like to change it to?"
				if [ $NEWMAIL ]; then
					echo -e "The current replacement is $NEWMAIL"
				fi
			read NEWMAIL
			echo -e "\n"
			echo "$NEWMAIL will be your new admin's e-mail"
			read -p "Press enter to continue"
			echo -e "\n"
			echo "========================================================================================="
			echo "                                     SMTP Relay Host                                     "
			echo "========================================================================================="
			echo -e " Currently, the SMTP host is $SMTP \n What would you like to change it to?"
				if [ $NEWSMTP ]; then
					echo -e "The current replacement is $NEWSMTP"
				fi
			read NEWSMTP
			echo -e "\n"
			echo "$NEWSMTP will be your new SMTP host"
			read -p "Press enter to continue"
			echo -e "\n"
			echo "========================================================================================="
			echo "                                       TACACS+ Key                                       "
			echo "========================================================================================="
			echo -e " Currently, the TACACS+ key is $KEY \n What would you like to change it to?"
			echo -e " ***WARNING, YOU WILL NEED TO CHANGE ALL ROUTER CONFIGS TO MATCH THE NEW ONE***"
				if [ $NEWKEY ]; then
					echo -e "The current replacement is $NEWKEY"
				fi
			read NEWKEY
			echo -e "\n"
			echo "$NEWKEY is your new TACACS+ key. If your routers don't match, they will be inaccessible"
			read -p "Press enter to continue"
			echo -e "\n"
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
			read -p "Press enter to continue"
			echo -e "\n"
			read -p "Are you certain you want to commit these changes? There will be no way to undo them. (yes/no)" yn
    			case $yn in
        			[Yy]* )
						find -type f -name '$FILES' | xargs sed -i 's/\$ORG/\$NEWORG/g'
						find -type f -name '$FILES' | xargs sed -i 's/\$WEB/\$NEWWEB/g'
						find -type f -name '$FILES' | xargs sed -i 's/\$MAIL/\$NEWMAIL/g'
						find -type f -name '$FILES' | xargs sed -i 's/\$SMTP/\$NEWSMTP/g'
						find -type f -name '$FILES' | xargs sed -i 's/\$KEY/\$NEWKEY/g'
						;;
					[Nn]* ) exit
						;;
        			* ) echo "Please answer yes or no.";;
    			esac
			;;
	1) 	while [ "$yn" != [Yy]* ]; do
			echo "========================================================================================="
			echo "                                    Organization Name                                    "
			echo "========================================================================================="
			echo -e " Currently, the organization name is $ORG \n What would you like to change it to?"
				if [ $NEWORG ]; then
					echo -e "The current replacement is $NEWORG"
				fi
			read NEWORG
			echo -e "\n"
			echo "$NEWORG will be your new organization name"
			echo "Would you like to continue? \"No\" will restart this section (yes/no)"
  			read yn
		done
				;;
	2) 	while [ "$yn" != [Yy]* ]; do
			echo "========================================================================================="
			echo "                                      Web Host Name                                      "
			echo "========================================================================================="
			echo -e " Currently, the website's hostname is $WEB \n What would you like to change it to?"
			echo -e " NOTE: If you would like to make this site https, include it in the hostname"
				if [ $NEWWEB ]; then
					echo -e "The current replacement is $NEWWEB"
				fi
			read NEWWEB
			echo -e "\n"
			echo "$NEWWEB will be your new host address"
			echo "Would you like to continue? \"No\" will restart this section (yes/no)"
  			read yn
		done
			echo -e "\n" 
				;;
	3) 	while [ "$yn" != [Yy]* ]; do
			echo "========================================================================================="
			echo "                                   Administrator Mail                                    "
			echo "========================================================================================="
			echo -e " Currently, the admin's mail address is $MAIL \n What would you like to change it to?"
				if [ $NEWMAIL ]; then
					echo -e "The current replacement is $NEWMAIL"
				fi
			read NEWMAIL
			echo -e "\n"
			echo "$NEWMAIL will be your new admin's e-mail"
			echo "Would you like to continue? \"No\" will restart this section (yes/no)"
  			read yn
		done
				;;
	4) 	while [ "$yn" != [Yy]* ]; do
			echo "========================================================================================="
			echo "                                     SMTP Relay Host                                     "
			echo "========================================================================================="
			echo -e " Currently, the SMTP host is $SMTP \n What would you like to change it to?"
				if [ $NEWSMTP ]; then
					echo -e "The current replacement is $NEWSMTP"
				fi
			read NEWSMTP
			echo -e "\n"
			echo "$NEWSMTP will be your new SMTP host"
			echo "Would you like to continue? \"No\" will restart this section (yes/no)"
  			read yn
		done
				;;
	5) 	while [ "$yn" != [Yy]* ]; do
			echo "========================================================================================="
			echo "                                       TACACS+ Key                                       "
			echo "========================================================================================="
			echo -e " Currently, the TACACS+ key is $KEY \n What would you like to change it to?"
			echo -e " ***WARNING, YOU WILL NEED TO CHANGE ALL ROUTER CONFIGS TO MATCH THE NEW ONE***"
				if [ $NEWKEY ]; then
					echo -e "The current replacement is $NEWKEY"
				fi
			read NEWKEY
			echo -e "\n"			
			echo "$NEWKEY is your new TACACS+ key. If your routers don't match, they will be inaccessible"
			echo "Would you like to continue? \"No\" will restart this section (yes/no)"
  			read yn
		done
				;;
	[Vv] ) clear
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
			read -p "Press enter to continue" 
			echo -e "\n"
				;;
	[Cc] ) read -p "Are you certain you want to commit these changes? There will be no way to undo them. (yes/no)" yn
    		case $yn in
        		[Yy]* )
					if [ $NEWORG ]; then
						for f in $FILES; do
							find -type f -name $f | xargs sed -i 's/\$ORG/\$NEWORG/g'
						done
						fi

					if [ $NEWWEB ]; then
						for f in $FILES; do
							find -type f -name $f | xargs sed -i 's/\$WEB/\$NEWWEB/g'
						done
						fi
					
					if [ $NEWMAIL ]; then
						for f in $FILES; do
							find -type f -name $f | xargs sed -i 's/\$MAIL/\$NEWMAIL/g'
						done
						fi
						
					if [ $NEWSMTP ]; then
						for f in $FILES; do
							find -type f -name $f | xargs sed -i 's/\$SMTP/\$NEWSMTP/g'
						done
						fi
					
					if [ $NEWKEY ]; then
						for f in $FILES; do
							find -type f -name $f | xargs sed -i 's/\$KEY/\$NEWKEY/g'
						done
						fi
					;;
				[Nn]* ) exit
					;;
        		* ) 
				;;
    		esac

			;;
	[Qq] ) clear
			exit 
			;;
esac
done