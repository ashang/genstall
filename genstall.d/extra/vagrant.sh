#!/usr/bin/env bash
set -o errexit
source /tmp/00-settings.sh
[[ $(whoami) == 'root' ]] || exec sudo su -c $0 root

$_CHROOT useradd -m -s /bin/bash vagrant
$_CHROOT passwd vagrant << EOF
vagrant
vagrant
EOF

mkdir -p /mnt/gentoo/home/vagrant/.ssh
cat > /mnt/gentoo/home/vagrant/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==
EOF
$_CHROOT chmod -R 0700 /home/vagrant/.ssh/
$_CHROOT chmod -R 0600 /home/vagrant/.ssh/authorized_keys
$_CHROOT chown -R vagrant:vagrant /home/vagrant/.ssh/

_EMERGE app-admin/sudo
cat >> /mnt/gentoo/etc/sudoers << EOF
vagrant ALL=(ALL) NOPASSWD: ALL
EOF
