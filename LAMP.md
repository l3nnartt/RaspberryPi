# LAMPE & TEMPERATUR

In einer vorherigen Stunde war es unsere Aufgabe ein Script zu schreiben welches die Temperatur eines Temperatur Sensors ausliest.
Dafür mussten wir etwas vorarbeitet leisten, dazu haben wir folgendes Tutorial genutzt:
https://www.circuitbasics.com/raspberry-pi-ds18b20-temperature-sensor-tutorial/

Anschließend haben wir mit folgendem Script unsere Temperatur abgefragt:

```python
def getTemp():
  with open('/sys/bus/w1/devices/28-420b740e64ff/w1_slave') as file:
    # Read the sensor data
    s = file.read()
    
    # Split the data by the equal sign '=' and get the temperature value
    temp_str = s.split('=')[-1].strip()
    
    # Convert the temperature value from string to integer and then to Kelvin
    temp_celsius = round(int(temp_str) / 1000, 2)

  # Print the temperature
  print("Temperature: ", temp_celsius)

# Call the getTemp function to get the temperature
getTemp()
```

Mit der Hilfe dieses Python Scripts, haben wir schlussendlich ein Script geschrieben welches eine LED leuchten lässt, sofern eine eingestellte Temperatur überschritten wird.
Als zusätzliche * Aufgabe speichern wir die ausgelesenen Daten in einer Datenbank & versenden eine Mail beim Start des Monitorings sowie sollte die gewünschte Temperatur überschritten werden.
Das Script dazu sieht schlussendlich wie folgt aus:

```python
import time
from gpiozero import LED

# mail imports
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Variablen
highTemp = 30
lowTemp = 20
highTempText = "Temperatur zu hoch!"
lowTempText = "Temperatur zu niedrig!"
normalTempText = "Temperatur im Normalbereich!"
path = "/sys/bus/w1/devices/28-f7ec770e64ff/w1_slave"
led = LED(17)

# E-Mail Konfiguration
sender = "SENDER"
empfaenger = "RECEIVER"
passwort = "PASSWORT"
smtpserver = "SERVER"
smtpport = 465

def getTemp():
    with open(path) as file:
        s = file.read()
        temp_str = s.split('=')[-1].strip()
        temp_celsius = round(int(temp_str) / 1000, 2)
        return temp_celsius


def Main():
    sendMail("Temperaturüberwachung gestartet", "Das Programm zur Temperaturüberwachung wurde gestartet!")
    while True:
        print("Temp: ", getTemp())
        if(getTemp() > highTemp):
            print(highTempText)
            led.on()
            sendMail("Temperatur zu hoch!", "Die Temperatur ist zu hoch! \n " + str(getTemp()) + "°C")
        elif(getTemp() < lowTemp):
            print(lowTempText)
            led.on()
            sendMail("Temperatur zu niedrig!", "Die Temperatur ist zu niedrig!  \n " + str(getTemp()) + "°C")
        else:
            led.off()
            print(normalTempText)
            insertIntoSQL(None)

# methode weil faul für clean timestamp
def getTimeAndDate():
    return time.strftime('%H:%M:%S %d-%m-%Y')

def sendMail(Subject, Text):
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = empfaenger
    msg['Subject'] = Subject
    msg.attach(MIMEText(Text, 'plain'))
    # on every method call we start this, rework!!
    server = smtplib.SMTP_SSL(smtpserver, smtpport)
    server.login(sender, passwort)
    server.sendmail(sender, empfaenger, msg.as_string())
    server.quit()

if __name__ == "__main__":
    Main()
```