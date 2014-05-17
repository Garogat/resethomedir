#!/bin/bash
echo "Die aktuellste Script Version wird nun heruntergeladen."
sudo wget http://armin.jacob.fsg-preetz.org/resethomedir.txt
if [ -w resethomedir.txt ]
then
echo "Datei wurde erfolgreich heruntergeladen!"
sudo mv resethomedir.txt resethomedir
sudo chmod 755 resethomedir
sudo mv resethomedir /etc/init.d/
chmod 755 /etc/init.d/resethomedir
if [ -w /etc/init.d/resethomedir ]
then
echo "Die Datei wurde erfolgreich kopiert, die Rechte gesetzt und es existiert Schreibzugriff."
else
echo "Die Datei wurde erfolgreich kopiert, aber es existiert kein Schreibzugriff! Das Script wird abgebrochen!"
exit 2
fi
echo "Das Script wird nun angepasst."
sudo sed -i -e 13d /etc/init.d/resethomedir
wait
sudo sed -i '12aUSER=student' /etc/init.d/resethomedir
wait
echo "Das Script wurde angepasst."
sudo insserv /etc/init.d/resethomedir
wait
echo "Das Script wurde im Autostart verankert."
echo "Es wird nun eine erste Sicherung erstellt."
sudo /etc/init.d/resethomedir save
wait
echo "Die Installation wurde inklusvie einer ersten Sicherung abgeschlossen. Das Installationsscript löscht sich nun!"
sudo rm /home/.saves/student/Downloads/opensuseconfig.sh
sudo rm opensuseconfig.sh
else
echo "Download der Datei nicht erfolgreich!"
fi