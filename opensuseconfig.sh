#!/bin/bash
#Dieses Script wurde von Armin Jacob unter GNU/GPLv2 veröffentlich
echo "Die aktuellste Script Version wird nun heruntergeladen."
sudo wget https://raw.githubusercontent.com/nimra98/resethomedir/master/resethomedir
if [ -w resethomedir ]
then
echo "Datei wurde erfolgreich heruntergeladen!"
read -p "Wessen Benutzerkonto soll abgesichert werden? Bitte achten sie auf die Rechtschreibung!
" name
read -p "Möchten sie einen abweichenden Pfad für die Sicherungen angeben? (Standard: /home/.saves/*) Falls Ja geben sie ihn bitte hier ein, ansonsten drücken sie bitte nur ENTER!
" direction
read -p "Bitte bestätigen sie, dass die Sicherung für folgenden Benutzer angelegt werden soll: $name (Ja/Nein)
" confirmation1
if [ "$confirmation1" == "Ja" ]
then
echo "Script wird kopiert!"
sudo cp resethomedir /etc/init.d/
sudo chmod 755 /etc/init.d/resethomedir
if [ -w /etc/init.d/resethomedir ]
then
echo "Die Datei wurde erfolgreich kopiert, die Rechte gesetzt und es existiert Schreibzugriff."
else
echo "Die Datei wurde erfolgreich kopiert, aber es existiert kein Schreibzugriff! Der Vorgang wird jetzt wahrscheinlich mit vielen Fehlern beendet!"
fi
echo "Das Script wird nun angepasst."
sudo sed -i -e 13d /etc/init.d/resethomedir
wait
sudo sed -i '12aUSER='$name'' /etc/init.d/resethomedir
wait
if [ "$direction" == "" ]
then
echo "Es wird das Standardverzeichnis verwendet."
else
sudo sed -i -e 13d /etc/init.d/resethomedir
wait
sudo sed -i '13aTMPDIR='$direction'' /etc/init.d/resethomedir
fi
echo "Das Script wurde angepasst."
sudo insserv /etc/init.d/resethomedir
wait
echo "Das Script wurde im Autostart verankert."
read -p "Möchtest du jetzt eine erste Sicherung erstellen? (Ja/Nein)
" confirmation2
if [ "$confirmation2" == "Ja" ]
then
sudo /etc/init.d/resethomedir save
wait
echo "Die Installation wurde inklusvie einer ersten Sicherung abgeschlossen."
else
echo "Die Installation wurde ohne erste Sicherung abgeschlossen! Bitte führen sie dies nun manuell durch."
fi
else
echo "Vorgang wurde abgebrochen!"
fi
else
echo "Download der Datei nicht erfolgreich!"
fi
