#!/bin/bash

# VARIABLES
TACCONF="/etc/tacacs+/tac_plus.conf"

#Error codes
errorformat="Incorrect formatting, please use this format: tacdelete -u [USERNAME] -p [PASSWORD] -e [EMAIL] -n [NAME]"
errormail="To delete your account, you must provide a matching, valid [ORGPLACEHOLDER].gov e-mail address"
errorconfig="Tacacs+ configuration file not found! Contact an administrator ASAP! (This is very bad)"
errorrestart="The tacacs_plus service failed to restart. Please fix this to enable tacacs again. (This is bad)"
errornobody="The user does not appear to exist, check your input and try again"
errortryagain="Failed to delete this account, try again"

#Logs input data before any opportunity for exit codes
echo "<----`date`---->" >> /opt/bin/taclog
echo "...Delete Attempt..."
echo "$0 $1 $2 $3 $4 $5 $6 $7 $8 $9" >> /opt/bin/taclog

#Exit-worthy errors in the command line syntax
if [ "$#" -lt "6" ] || [ "$1" != "-u" ] || [ "$3" != "-e" ] || [ "$5" != "-n" ]
then
    echo $errorformat | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[ERROR\]/$errorformat/" /opt/bin/mailscripterror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 1
fi
USERNAME="$2"
shift; shift
EMAIL="$2"
shift; shift; shift
NAME="$@"

#Logs registration attempts with all known data
echo -e "$USERNAME\n$EMAIL\n$NAME" >> /opt/bin/taclog

#Checks if the e-mail provided is a [ORGPLACEHOLDER].gov address
if ! [[ $EMAIL =~ "@[ORGPLACEHOLDER].gov" ]]; then
    echo $errormail | tee -a /opt/bin/taclog
    echo $errortryagain | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[ERROR\]/$errormail/" /opt/bin/mailscripterror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 2
fi

#Logs the user out
pkill -KILL -u $USERNAME

#Check makes sure if the user already exists
if ! lslogins -l $USERNAME | grep "$NAME" | grep $EMAIL
then
    echo $errornobody | tee -a /opt/bin/taclog
    echo $errortryagain | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[USERNAME\]/$USERNAME/" /opt/bin/mailusererror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 3
fi

#Backs up important files before user deletion
/opt/bin/backup.sh

#Deletes the user using provided information
deluser $USERNAME
rm -r /home/$USERNAME

#!!!EDIT THIS!!!Adds the user to the tacacs configuration file
echo $USERNAME
echo $TACCONF
sed -i -e "/$USERNAME/d" $TACCONF

#If there is no tacacs configuration file, then you have a bad problem and need to contact an administrator
if [ ! -f $TACCONF ]; then
    echo $errorconfig | tee -a /opt/bin/taclog
    echo $errortryagain | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[ERROR\]/$errorconfig/" /opt/bin/mailscripterror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 4
fi

# Rewrites the template e-mail with all the collected variables and sends it to the registering user
sed -e "s/\[NAME\]/$NAME/" -e "s \[USER\] $USERNAME " /opt/bin/maildelete | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL

#Restart tacacs service so the newly registered user is available
systemctl restart tacacs_plus
systemctl is-active tacacs_plus
if [ $? -eq 0 ]
then
    echo "User removed without errors" | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    exit 0
else
    echo $errorrestart | tee -a /opt/bin/taclog
    echo $errortryagain | tee -a /opt/bin/taclog
    echo "<--------------END-LOG--------------->" | tee -a /opt/bin/taclog
    echo "" | tee -a /opt/bin/taclog
    sed -e "s/\[NAME\]/$NAME/" -e "s/\[ERROR\]/$errorrestart/" /opt/bin/mailscripterror | mail -aFrom:[MAILPLACEHOLDER] -aBCC:[MAILPLACEHOLDER] -s "[ORGPLACEHOLDER] Official Tacacs+ Registration" $EMAIL
    exit 5
fi