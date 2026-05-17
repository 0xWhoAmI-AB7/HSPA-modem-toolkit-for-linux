#!/bin/bash

# Ensure the script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script using sudo (e.g., sudo ./setup_hspa_modem.sh)"
  exit 1
fi

echo "=========================================="
echo " Starting HSPA 1c9e:6061 Modem Setup Script"
echo "=========================================="

# 1. Configure the Kernel Module Options
echo "[+] Configuring /etc/modprobe.d/nedjma.conf..."
echo "options usbserial vendor=0x1c9e product=0x6061" > /etc/modprobe.d/nedjma.conf

# 2. Configure Hardware Automation (udev Rules)
echo "[+] Creating /etc/udev/rules.d/99-nedjma-modem.rules..."
cat << 'EOF' > /etc/udev/rules.d/99-nedjma-modem.rules
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="1c9e", ATTRS{idProduct}=="6061", RUN+="/usr/sbin/usb_modeswitch -v 1c9e -p 6061 -I -M 55534243123456780000000000000606f50402527000000000000000000000"
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="1c9e", ATTRS{idProduct}=="6061", RUN+="/sbin/modprobe option"
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="1c9e", ATTRS{idProduct}=="6061", RUN+="/bin/sh -c 'sleep 2; echo 1c9e 6061 > /sys/bus/usb-serial/drivers/option1/new_id'"
EOF

# 3. Reload Rules and Refresh Modules
echo "[+] Reloading udev rules engine..."
udevadm control --reload-rules
udevadm trigger

echo "[+] Cycling kernel serial drivers..."
modprobe -r option 2>/dev/null
modprobe option

# 4. Clear Old/Duplicate Profiles from NetworkManager
echo "[+] Cleaning old NetworkManager connection profiles..."
nmcli connection delete "Mobilis" 2>/dev/null
nmcli connection delete "Mobilis 1" 2>/dev/null
nmcli connection delete "Ooredoo" 2>/dev/null
nmcli connection delete "Djezzy" 2>/dev/null

# 5. Build Fresh Profiles with the Correct APNs
echo "[+] Creating clean network provider profiles..."
nmcli connection add type gsm ifname ttyUSB0 con-name "Mobilis" apn internet
nmcli connection add type gsm ifname ttyUSB0 con-name "Ooredoo" apn internet.ooredoo.dz
nmcli connection add type gsm ifname ttyUSB0 con-name "Djezzy" apn djezzy.internet

echo "=========================================="
echo " Configuration Complete!"
echo "=========================================="
echo "Please do the following now:"
echo "1. Unplug your HSPA dongle."
echo "2. Wait 15 seconds."
echo "3. Plug it back in."
echo "4. Use your GNOME/KDE panel menu to choose your profile."
echo "=========================================="
