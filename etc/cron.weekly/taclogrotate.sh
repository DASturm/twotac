$DATE=$(date +"%m-%d-%y")
cp /opt/bin/taclogs/taclog /opt/bin/taclogs/taclog$DATE
rm /opt/bin/taclogs/taclog
echo -e "END WEEKLY LOG\n$DATE" >> /opt/bin/taclogs/taclog$DATE
