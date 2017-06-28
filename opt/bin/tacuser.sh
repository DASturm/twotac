#!/bin/bash

# VARIABLES
TACCONF="/etc/tacacs+/tac_plus.conf"

#Error codes
errorformat="Incorrect formatting, please use this format: tacuser -u [USERNAME] -p [PASSWORD] -e [EMAIL] -n [NAME]"
errorconfig="Tacacs+ configuration file not found! Contact an administrator ASAP! (This is very bad)"
errordup="The username you're adding already exists.  Please check the username and try again."
errorrestart="The tacacs_plus service failed to restart. Please fix this to enable tacacs again. (This is bad)"

#Logs input data before any opportunity for exit codes
echo "<----`date`---->" >> /opt/bin/taclog
echo "$0 $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11" >> /opt/bin/taclog

#Exit-worthy errors in the command line syntax
if [ "$#" -lt "8" ] || [ "$1" != "-u" ] || [ "$3" != "-p" ] || [ "$5" != "-e" ] || [ "$7" != "-n" ]
then
    echo $errorformat | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[ERROR\]/$errorformat/" /opt/bin/mailscripterror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 1
fi
USERNAME="$2"
shift; shift
PASSWORD="$2"
shift; shift
EMAIL="$2"
shift; shift; shift
NAME="$@"

#Logs registration attempts with all known data
echo -e "$USERNAME\n$PASSWORD\n$EMAIL\n$NAME" >> /opt/bin/taclog

# Check if the user is already exists
if grep -qe "^$USERNAME:" $TACCONF
then
    echo $errordup | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[USERNAME\]/$USERNAME/" /opt/bin/mailusererror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 3
fi
if grep -qe "^$USERNAME:" /etc/passwd
then
    echo $errordup | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[USERNAME\]/$USERNAME/" /opt/bin/mailusererror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 3
fi

#Adds the user using provided information
adduser --disabled-password --gecos "$NAME,,,,$EMAIL" $USERNAME
usermod -a -G tacusers $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd -e

#Adds the user to the tacacs configuration file
sed -i "s/#END FILE/user = \"$USERNAME\" { login = PAM member = ADMIN service = exec { priv-lvl = 15 }  }/" $TACCONF
echo '#END FILE' >> $TACCONF

#If there is no tacacs configuration file, then you have a bad problem and need to contact an administrator
if [ ! -f $TACCONF ]; then
    echo $errorconfig | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[ERROR\]/$errorconfig/" /opt/bin/mailscripterror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 4
fi

#This section runs the google-authenticator command and saves the output to a file
su -c "echo -e \"y\n\ny\ny\nn\ny\" | google-authenticator" $USERNAME > /tmp/$USERNAME-auth

#Searches the authorization file registered above for the QR code URL
URL=`egrep -o 'https?://[^ ]+' /tmp/$USERNAME-auth`

#Saves the QR code as a .png
wget --no-check-certificate $URL -O /tmp/$USERNAME-QR.png -o /tmp/$USERNAME-wget.log

#If registration was successful, it will be logged
    echo "$NAME registered successfully" >> /opt/bin/taclog

#Rewrites the template e-mail with all the collected variables and sends it to the registering user
sed -e "s/\[NAME\]/$NAME/" -e "s \[QRURL\] $URL " /opt/bin/mailtemplate | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" -A /tmp/$USERNAME-QR.png $EMAIL

#Restart tacacs service so the newly registered user is available, and if successful, backs up all the important files.
systemctl restart tacacs_plus
systemctl is-active tacacs_plus
if [ $? -eq 0 ]
then
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    /opt/bin/backup.sh
    exit 0
else
    echo $errorrestart | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[ERROR\]/$errorrestart/" /opt/bin/mailscripterror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 5
fi