# Einrichtung eines Rasberry Pi

## Prerequisites
- Raspberry Pi
- Raspberry Pi Imager
- SD-Card/USB-Stick

## Aufgabe 1
### Schritt 1
Über den Raspberry Pi Imager wurde die erste initiale Konfiguration vorgenommen.
Wenn wir den Imager öffnen erhalten wir folgende Ansicht:
![img.png](assets/foto1.png)

Dort stellen wir folgende Dinge ein:\
Device: Raspberry Pi 3\
OS: Raspberry Pi OS Lite\
Storage: SD Card

### Schritt 2
Verbindung via. SSH testen, dafür nutzen wir das zuvor konfigurierte Gerät.
Wir haben als Hostname `lennart-pi.local` festgelegt und als nutzer `lennart`.
Das ganze sieht dann folgendermaßen aus:
```
PS C:\Users\l.loesche> ssh lennart@lennart-pi.local
```
Anschließend werden wir (sofern festgelegt) nach der Passphrase von unserem SSH Key gefragt.
Diesen geben wir nun ein und anschließend haben wir erfolgreich eine SSH Verbindung zu unserem Rasberry Pi aufgebaut.
```
PS C:\Users\l.loesche> ssh lennart@lennart-pi.local
Enter passphrase for key 'C:\Users\l.loesche/.ssh/id_ed25519':
Linux lennart-pi 6.1.21-v8+ #1642 SMP PREEMPT Mon Apr  3 17:24:16 BST 2023 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Feb 29 13:52:21 2024 from fe80::be30:f564:9b59:5375%wlan0
lennart@lennart-pi:~ $
```

## Aufgabe 2
Nun wollen wir, dass der Raspberry Pi in den Schul-Hotspot kommt.
Dieser ist ein WLAN-Netzwerk, welches über einen Radius Server geschützt ist.
Die Herausforderung ist also unsere Zugangsdaten auf dem Pi gehasht zu hinterlegen.
```
lennart@lennart-pi:~ $ sudo cat /etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
        ssid="Labor-Client"
        psk=578abce8e3f9a9a00cb37328f78a7166a5017d077a4dcd480074887318649231
}
```