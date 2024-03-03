#!/bin/bash

# Update and upgrade Termux
pkg update
pkg upgrade -y

# Install necessary packages
pkg install proot wget tar figlet -y

# Create a directory for Ubuntu installation
mkdir ~/ubuntu
cd ~/ubuntu

# Download the Ubuntu root filesystem
wget https://partner-images.canonical.com/core/xenial/current/ubuntu-xenial-core-cloudimg-armhf-root.tar.gz

# Extract the root filesystem
proot --link2symlink tar -xf ubuntu-xenial-core-cloudimg-armhf-root.tar.gz

# Configure Ubuntu to work within Termux
echo 'nameserver 8.8.8.8' > ~/ubuntu/etc/resolv.conf
echo '127.0.0.1 localhost' > ~/ubuntu/etc/hosts

# Chroot into Ubuntu
proot -0 -r ~/ubuntu -b /dev -b /proc -b /sys /usr/bin/env -i HOME=/root TERM="xterm-256color" LANG=en_US.UTF-8 PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login

# After running this script, you'll be inside the chrooted Ubuntu environment.
# You can exit the environment by typing "exit".
