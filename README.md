# piscripts
##### Scripts to setup a new pi
*1. Change the hostname*
```
sudo nano /etc/hostname
```
*2. Change the default user name*
```
sudo passwd root
sudo nano /etc/ssh/sshd_config
PermitRootLogin yes
logout
login as root
pkill -KILL -u pi; usermod -l myuname pi
usermod -m -d /home/myuname myuname
logout
login as myuname
passwd
sudo passwd -l root
sudo nano /etc/ssh/sshd_config
PermitRootLogin no
```
*3. Update the OS*
```
sudo apt-get update

sudo apt-get upgrade
```
*4. Install sqlite3*
```
sudo apt-get install sqlite3
```
*5. Install git*
```
sudo apt install git
```
*6. Clone piscripts*
```
git clone https://github.com/dasearle/piscripts.git
cd piscripts
mv * ../
```
*7. Set temp monitoring running...*
```
sudo chmod +x temp.sh
export EDITOR=nano; crontab -e

* * * * * ~/temp.sh
```

*8. Install power switch scripts:*
```
git clone https://github.com/Howchoo/pi-power-button.git

./pi-power-button/script/install
```
*9. Collect wifi credentials using webpage and update wifi settings*
Clone and install raspiWIFI
```
wget https://github.com/jasbur/RaspiWiFi.git
sudo python3 initial_setup.py
sudo shutdown -r now
```

*10. (optional) Setup auto hotspot*
IGNORE THIS UNLESS STEP 9 DOES NOT WORK
```
sudo apt-get install hostapd
sudo apt-get install dnsmasq
sudo systemctl unmask hostapd
sudo systemctl disable hostapd
sudo systemctl disable dnsmasq
sudo cp hostapd.conf /etc/hostapd/
sudo nano /etc/default/hostapd
Change:
#DAEMON_CONF=""
to
DAEMON_CONF="/etc/hostapd/hostapd.conf"

Check the DAEMON_OPTS="" is preceded by a #, so is #DAEMON_OPTS=""
sudo cp dnsmasq.conf /etc/
sudo cp /etc/network/interfaces /etc/network/interfaces-backup
sudo nano /etc/dhcpcd.conf
Add line at bottom: nohook wpa_supplicant
sudo cp autohotspot.service /etc/systemd/system/
sudo systemctl enable autohotspot.service
sudo cp autohotspot /usr/bin
sudo chmod +x /usr/bin/autohotspot

export EDITOR=nano; crontab -e

*/5  * * * sudo /usr/bin/autohotspot >/dev/null 2>&1

```

## Install raylib 2.5

wget https://github.com/raysan5/raylib/archive/2.5.0.zip

unzip 2.5.0.zip

rm 2.5.0.zip

mv raylib-2.5.0 raylib

sudo raspi-config

select Legacy video driver

sudo apt-get install --no-install-recommends raspberrypi-ui-mods lxterminal gvfs
sudo apt-get install mesa-common-dev
sudo apt-get install libgl1-mesa-dev
sudo apt-get install libxcursor-dev
sudo apt-get install libxinerama-dev
sudo apt-get install libxrandr-dev
sudo apt-get install libxi-dev
sudo apt-get install libasound2-dev

--Doesn't work with Raspbian Lite...





