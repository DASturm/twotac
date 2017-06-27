#!/bin/bash
DATE = `date -u +%Y-%m-%dT%H:%MZ`
ALLFILES = "/opt/bin/ /var/www/html/ /etc/apache2/ /etc/tacacs+/tac_plus.conf /etc/pam.d/tac_plus /etc/postfix/main.cf /etc/ssh/sshd_config /home/ /etc/cron.weekly/backup.sh"
tar -zcvf /opt/backups/"$DATE"tacbackups.tar.gz $ALLFILES
/opt/bin/mailbackup | mail -aFrom:MAILPLACEHOLDER -s "Tacacs+ Backup" -A /opt/backups/"$DATE"tacbackups.tar.gz MAILPLACEHOLDER