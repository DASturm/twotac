#!/bin/bash
rm  /opt/bin/*
rm -r /var/www/html
rm -r /home/minibox/projects/Twotac-Files
git clone https://github.com/dsturm-l/Twotac-Files.git /home/minibox/projects/Twotac-Files
cp -r /home/minibox/projects/Twotac-Files/etc/ /
cp -r /home/minibox/projects/Twotac-Files/opt/ /
cp -r /home/minibox/projects/Twotac-Files/var/ /
chmod u+x /opt/bin/*.sh
