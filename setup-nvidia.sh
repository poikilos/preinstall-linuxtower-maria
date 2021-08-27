#!/bin/sh
#!/bin/bash

# See <https://superuser.com/a/1620786/1001420>:
sudo prime-select nvidia

if [ ! -f "`command -v nvidia-xconfig`" ]; then
    echo "The command is not present. Install the nvidia driver with the version matching your GPU first."
    exit 1
fi

sudo mv /etc/X11/xorg.conf "/etc/X11/xorg.conf-`date '+%Y-%m-%d'`"

# See <https://askubuntu.com/a/1255010/766334>:
sudo dpkg-reconfigure -phigh xserver-xorg
sudo nvidia-xconfig

echo "- First, reboot to load the new xorg.conf."
echo "- Next, you must manually set the resolution using the NVIDIA X Server Settings GUI (Apply, then Save & choose merge with existing /etc/X11/xorg.conf generated by the previous commands in this script)."

cat <<END
You may have to do
sudo apt purge *nvidia*
# (See See liutis Jul 23 at 8:58 reply on <https://superuser.com/a/1448682/1001420>) but not
# sudo ubuntu-drivers autoinstall
# ^ which installs version 470 since 390 is not marked "tested".
# Instead, choose the correct version in the "Additional Drivers" GUI
# of Ubuntu, such as 390 for GeForce 700 series GPUs.  
END
