#!/bin/bash
DATE = `date -u +%Y-%m-%dT%H:%MZ`
ALLFILES = "/opt/bin/ /var/www/html/ /etc/apache2/ /etc/tacacs+/tac_plus.conf /etc/pam.d/tac_plus /etc/postfix/main.cf /etc/ssh/sshd_config /home/ /etc/cron.weekly/backup.sh"
MAILER="MAILPLACEHOLDER"
MAILDIR="/opt/bin"
tar -zcvf /opt/tacbackups/"$DATE"tacbackups.tar.gz $ALLFILES
$MAILDIR/mailbackup | mail -aFrom:$MAILER -s "Tacacs+ Backup" -A /opt/tacbackups/"$DATE"tacbackups.tar.gz $MAILER