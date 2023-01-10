#! /usr/bin/bash

# обновим систему
apt update
apt upgrade -y

# сбросим конфиги дисков
apt install -y mdadm vim parted
mdadm --zero-superblock --force /dev/sd{b,c,d,e}

# создадим рейд
mdadm --create --verbose /dev/md127 -l 5 -n 4 /dev/sd{b,c,d,e}

# форматируем и монтируем
#mkfs.ext4 /dev/md127
#mkdir /mnt/md127
#mount /dev/md127 /mnt/md127
#cp -r /var/log/* /mnt/md127/
#echo "/dev/md127 /mnt/md127/ ext4" >> /etc/fstab

# запишем конфиг рейда
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf

# доп
parted -s /dev/md127 mklabel gpt
parted /dev/md127 mkpart primary ext4 0% 20%
parted /dev/md127 mkpart primary ext4 20% 40%
parted /dev/md127 mkpart primary ext4 40% 60%
parted /dev/md127 mkpart primary ext4 60% 80%
parted /dev/md127 mkpart primary ext4 80% 100%

for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md127p$i; done

mkdir /mnt/md127
mkdir -p /mnt/md127/part{1,2,3,4,5}

for i in $(seq 1 5); do mount /dev/md127p$i /mnt/md127/part$i; done
