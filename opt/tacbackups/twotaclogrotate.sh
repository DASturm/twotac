$DATE=$(date +"%m-%d-%y")
cp /var/log/twotac/taclog /var/log/twotac/taclog$DATE
rm /var/log/twotac/taclog
echo -e "END WEEKLY LOG\n$DATE" >> /var/log/twotac/taclog$DATE
