$DATE=$(date +"%m-%d-%y")
cp /var/log/taclogs/taclog /var/log/taclogs/taclog$DATE
rm /var/log/taclogs/taclog
echo -e "END WEEKLY LOG\n$DATE" >> /var/log/taclogs/taclog$DATE
