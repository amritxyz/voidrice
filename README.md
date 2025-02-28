# Installation

## Install Script
```bash
git clone --depth=1 https://github.com/amritxyz/void-install.git
```

## Window Manager
```bash
git clone --depth=1 https://github.com/amritxyz/void-dwm
```

## NetworkManager
```
sudo xbps-install NetworkManager &&
sudo rm -rf /var/service/dhcpcd &&
sudo rm -rf /var/service/wpa_supplicant &&
sudo ln -s /etc/sv/NetworkManager/ /var/service/ &&
sudo ln -s /etc/sv/dbus/ /var/service/ &&
sv up dhcpcd &&
sv up wpa_supplicant &&
```

## wpa_supplicant
```
/etc/wpa_supplicant/wpa_supplicant.conf

ctrl_interface=/run/wpa_supplicant
update_config=1

wpa_passphrase SSID passphrase >> /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf

wpa_supplicant -B -i interface -c wpa_supplicant-wlp2s0.conf
```

## Change Network
```
wpa_passphrase SSID passphrase >> /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf

pkill wpa_supplicant

wpa_supplicant -B -i interface -c wpa_supplicant-wlp2s0.conf
```
