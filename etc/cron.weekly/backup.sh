#!/bin/bash
DATE=`date -u +%Y-%m-%dT%H:%MZ`
ALLFILES="/etc/twotac/twotac.conf /etc/apache2/ /etc/tacacs+/tac_plus.conf /etc/pam.d/tac_plus /etc/postfix/main.cf /etc/ssh/sshd_config /etc/cron.weekly/ /opt/bin/ /opt/tacbackups/ /opt/tacconfigs/ /opt/tacmail/ /var/www/html/ /var/log/taclogs/ /home/"
MAILER="MAILPLACEHOLDER"
MAILDIR="/opt/tacmail"
tar -zcvf /opt/tacbackups/"$DATE"tacbackups.tar.gz $ALLFILES
$MAILDIR/mailbackup | mail -aFrom:$MAILER -s "Tacacs+ Backup" -A /opt/tacbackups/"$DATE"tacbackups.tar.gz $MAILER