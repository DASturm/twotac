#!/bin/bash
#Files variable may need work and may need to automatically gather file names/paths from a function
DIR=$(find /opt/bin/ /var/www/html/ -type f)
FILES="$DIR /etc/tacacs+/tac_plus.conf /etc/pam.d/tac_plus /etc/postfix/main.cf"
#This is where the current variables will be stored NOTE CHANGE TO /OPT/BIN/TAC.CONF WHEN TESTING IS OVER
trap '' 2
while true
do
source tac.conf
clear
yn="n"
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
echo " To commit changes to memory,       enter C"
echo " To exit,                           enter Q"
echo -e ""
echo " **NOTE: IF YOU DO NOT COMMIT, CHANGES WILL NOT BE SAVED**"
echo -e ""
if [ $NEWORG ] || [ $NEWWEB ] || [ $NEWMAIL ] || [ $NEWSMTP ] || [ $NEWKEY ]; then
	echo "====================================================="
	echo "                   Current Changes                   "
	echo "====================================================="
	echo -e " Original    \t\t::::\t    New"
	if [ $NEWORG ]; then
		echo -e " $ORG    \t::::\t    $NEWORG"
	fi
	if [ $NEWWEB ]; then
		echo -e " $WEB    \t::::\t    $NEWWEB"
	fi
	if [ $NEWMAIL ]; then
		echo -e " $MAIL    \t::::\t    $NEWMAIL"
	fi
	if [ $NEWSMTP ]; then
		echo -e " $SMTP    \t::::\t    $NEWSMTP"
	fi
	if [ $NEWKEY ]; then
		echo -e " $KEY    \t\t::::\t    $NEWKEY"
	fi
fi
echo "====================================================="
echo -e "Enter your selection"
echo "====================================================="
echo -e "\n"
read answer
case $answer in
	[Aa] ) 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                    Organization Name                                    "
			echo "========================================================================================="
			echo -e " Currently, the organization name is $ORG \n What would you like to change it to?"
				if [ $NEWORG ]; then
					echo -e "The current replacement is $NEWORG"
				fi
			echo ""
			read TEMPORG
			echo ""
			echo " $TEMPORG will be your new organization name"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWORG="$TEMPORG"
  			fi
		done
		yn="n"
	 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                      Web Host Name                                      "
			echo "========================================================================================="
			echo -e " Currently, the website's hostname is $WEB \n What would you like to change it to?"
			echo -e " NOTE: If you would like to make this site https, include it in the hostname"
				if [ $NEWWEB ]; then
					echo -e "The current replacement is $NEWWEB"
				fi
			echo ""
			read TEMPWEB
			echo ""
			echo " $TEMPWEB will be your new host address"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWWEB="$TEMPWEB"
  			fi
		done
		yn="n"
	 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                   Administrator Mail                                    "
			echo "========================================================================================="
			echo -e " Currently, the admin's mail address is $MAIL \n What would you like to change it to?"
				if [ $NEWMAIL ]; then
					echo -e "The current replacement is $NEWMAIL"
				fi
			echo ""
			read TEMPMAIL
			echo ""
			echo " $TEMPMAIL will be your new admin's e-mail"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWMAIL="$TEMPMAIL"
  			fi
		done
		yn="n"
	 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                     SMTP Relay Host                                     "
			echo "========================================================================================="
			echo -e " Currently, the SMTP host is $SMTP \n What would you like to change it to?"
				if [ $NEWSMTP ]; then
					echo -e "The current replacement is $NEWSMTP"
				fi
			echo ""
			read TEMPSMTP
			echo ""
			echo " $TEMPSMTP will be your new SMTP host"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWSMTP="$TEMPSMTP"
  			fi
		done
		yn="n"
	 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                       TACACS+ Key                                       "
			echo "========================================================================================="
			echo -e " Currently, the TACACS+ key is $KEY \n What would you like to change it to?"
			echo -e " ***WARNING, YOU WILL NEED TO CHANGE ALL ROUTER CONFIGS TO MATCH THE NEW ONE***"
				if [ $NEWKEY ]; then
					echo -e "The current replacement is $NEWKEY"
				fi
			echo ""
			read TEMPKEY
			echo ""			
			echo " $TEMPKEY is your new TACACS+ key. If your routers don't match, they will be inaccessible"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWKEY="$TEMPKEY"
  			fi
		done
		yn="n"
	    clear
			echo "====================================================="
			echo "                   Current Changes                   "
			echo "====================================================="
			echo -e " Original    \t\t::::\t    New"
			echo -e " $ORG    \t::::\t    $NEWORG"
			echo -e " $WEB    \t::::\t    $NEWWEB"
			echo -e " $MAIL    \t::::\t    $NEWMAIL"
			echo -e " $SMTP    \t::::\t    $NEWSMTP"
			echo -e " $KEY    \t\t::::\t    $NEWKEY"
			echo "====================================================="
			echo -e "\n"
			read -p " Are you certain you want to commit these changes? There will be no way to undo them. (yes/no)" yn
    		case $yn in
        		[Yy]* )
					if [ $NEWORG ]; then
						for f in $FILES; do
							find $f -type f -print0 | xargs -0 sed -i 's/'"$ORG"'/'"$NEWORG"'/g'
						done
						fi

					if [ $NEWWEB ]; then
						for f in $FILES; do
							find $f -type f -print0 | xargs -0 sed -i 's/'"$WEB"'/'"$NEWWEB"'/g'
						done
						fi

					if [ $NEWMAIL ]; then
						for f in $FILES; do
							find $f -type f -print0 | xargs -0 sed -i 's/'"$MAIL"'/'"$NEWMAIL"'/g'
						done
						fi

					if [ $NEWSMTP ]; then
						for f in $FILES; do
							find $f -type f -print0 | xargs -0 sed -i 's/'"$SMTP"'/'"$NEWSMTP"'/g'
						done
						fi

					if [ $NEWKEY ]; then
						for f in $FILES; do
							find $f -type f -print0 | xargs -0 sed -i 's/'"$KEY"'/'"$NEWKEY"'/g'
						done
						fi
					;;
				[Nn]* ) break
					;;
    		esac
			;;
	1) 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                    Organization Name                                    "
			echo "========================================================================================="
			echo -e " Currently, the organization name is $ORG \n What would you like to change it to?"
				if [ $NEWORG ]; then
					echo -e "The current replacement is $NEWORG"
				fi
			echo ""
			read TEMPORG
			echo ""
			echo " $TEMPORG will be your new organization name"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWORG="$TEMPORG"
  			fi
		done
				;;
	2) 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                      Web Host Name                                      "
			echo "========================================================================================="
			echo -e " Currently, the website's hostname is $WEB \n What would you like to change it to?"
			echo -e " NOTE: If you would like to make this site https, include it in the hostname"
				if [ $NEWWEB ]; then
					echo -e "The current replacement is $NEWWEB"
				fi
			echo ""
			read TEMPWEB
			echo ""
			echo " $TEMPWEB will be your new host address"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWWEB="$TEMPWEB"
  			fi
		done
				;;
	3) 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                   Administrator Mail                                    "
			echo "========================================================================================="
			echo -e " Currently, the admin's mail address is $MAIL \n What would you like to change it to?"
				if [ $NEWMAIL ]; then
					echo -e "The current replacement is $NEWMAIL"
				fi
			echo ""
			read TEMPMAIL
			echo ""
			echo " $TEMPMAIL will be your new admin's e-mail"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWMAIL="$TEMPMAIL"
  			fi
		done
				;;
	4) 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                     SMTP Relay Host                                     "
			echo "========================================================================================="
			echo -e " Currently, the SMTP host is $SMTP \n What would you like to change it to?"
				if [ $NEWSMTP ]; then
					echo -e "The current replacement is $NEWSMTP"
				fi
			echo ""
			read TEMPSMTP
			echo ""
			echo " $TEMPSMTP will be your new SMTP host"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWSMTP="$TEMPSMTP"
  			fi
		done
				;;
	5) 	until [[ "$yn" =~ ^[Yy](es)?$ ]]; do
			echo "========================================================================================="
			echo "                                       TACACS+ Key                                       "
			echo "========================================================================================="
			echo -e " Currently, the TACACS+ key is $KEY \n What would you like to change it to?"
			echo -e " ***WARNING, YOU WILL NEED TO CHANGE ALL ROUTER CONFIGS TO MATCH THE NEW ONE***"
				if [ $NEWKEY ]; then
					echo -e "The current replacement is $NEWKEY"
				fi
			echo ""
			read TEMPKEY
			echo ""			
			echo " $TEMPKEY is your new TACACS+ key. If your routers don't match, they will be inaccessible"
			echo " Would you like to continue? \"No\" will restart this section (yes/no/cancel)"
  			read yn
  			if [[ "$yn" =~ ^[Cc](ancel)?$ ]]; then
  				break
  			else
  				NEWKEY="$TEMPKEY"
  			fi
		done
				;;
	[Cc] ) read -p "Are you certain you want to commit these changes? There will be no way to undo them. (yes/no)" yn
    		case $yn in
        		[Yy]* )
					if [ $NEWORG ]; then
						sed -i "s/$ORG/$NEWORG/g" $FILES
						fi

					if [ $NEWWEB ]; then
						sed -i "s/$WEB/$NEWWEB/g" $FILES
						fi

					if [ $NEWMAIL ]; then
						sed -i "s/$MAIL/$NEWMAIL/g" $FILES
						fi

					if [ $NEWSMTP ]; then
						sed -i "s/$SMTP/$NEWSMTP/g" $FILES
						fi

					if [ $NEWKEY ]; then
						sed -i "s/$KEY/$NEWKEY/g" $FILES
						fi
					;;
				[Nn]* ) continue
					;;
    		esac
			;;
	[Qq] ) clear
			exit 
			;;
esac
done