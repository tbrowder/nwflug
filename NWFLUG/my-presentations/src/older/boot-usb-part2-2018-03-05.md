title: Creating a Bootable USB
<!-- insert-file headers.md -->
date: 2018-03-05

## Objectives

+ Create a bootable USB with a simple copy
+ Duplicate the USB
+ Create a bootable USB with a persistent partition

## Requirements

A GNU/Linux host computer

An iso file with a suitable live distribution:

+ debian-live-9.3.0-amd64-mate+nonfree.iso

GNU utilities needed:

+ bash
+ grub-install
+ lsblk
+ mkfs.ext4
+ mkfs.vfat

## Requirements

GNU utilities needed:

+ mount
+ parted
+ partprobe
+ sync
+ umount

## Requirements

Debian packages providing the utilities:

+ bash
+ coreutils
+ dosfstools
+ e2fsprogs
+ gparted
+ grub2-common
+ mount
+ parted
+ sed
+ util-linux

## Definitive Procedures

Debian Live Project:

<**<https://debian-live.alioth.debian.org/live-manual/stable/manual/html/live-manual.en.html#556>**>

## Warning

Proceed carefully, you can destroy your host system.  The safest
method uses a virtual machine.

## Procedures

Plug in a USB flash drive and, after it is mounted,
inspect your system and determine the target USB:

~~~
$ lsblk
...
~~~

Then, *carefully*, do the following as root:

~~~
# set some variables for convenience (and safety!)
iso=deb*iso
dev=/dev/sdb

# inspect the target
parted $dev -s print

if [[ ! -b ${dev} ]]; then
  echo "FATAL: '$dev' must be a target block device"
  exit 1
fi

if [[ "${dev}" =~ ^.*[0-9]$ ]]; then
  echo "target block device should be device, not a partition (must not end with digit)"
  exit 1
fi

echo "unmounting old partitions"
umount ${dev}*

lsblk ${dev}
echo "this will destroy data on ${dev}. abort now if unsure!"
read

echo "creating partitions"
parted ${dev} --script mklabel gpt
parted ${dev} --script mkpart EFI fat16 1MiB 10MiB
parted ${dev} --script mkpart live fat16 10MiB 3GiB
parted ${dev} --script mkpart persistence ext4 3GiB 100%
parted ${dev} --script set 1 msftdata on
parted ${dev} --script set 2 legacy_boot on
parted ${dev} --script set 2 msftdata on

echo "syncing and probing new partitions"
sync
partprobe

echo "creating file systems"
mkfs.vfat -n EFI ${dev}1
mkfs.vfat -n LIVE ${dev}2
mkfs.ext4 -F -L persistence ${dev}3

echo "creating temporary mount locations"
tmp=$(mktemp --tmpdir --directory debianlive.XXXXX)
tmpefi=${tmp}/efi
tmplive=${tmp}/live
tmppersistence=${tmp}/persistence
tmpiso=${tmp}/iso
tmpall="${tmpefi} ${tmplive} ${tmppersistence} ${tmpiso}"

echo "mounting resources"
mkdir ${tmpall}
mount ${dev}1 ${tmpefi}
mount ${dev}2 ${tmplive}
mount ${dev}3 ${tmppersistence}
mount -oro ${iso} ${tmpiso}

echo "copying iso image filesystem contents"
cp -ar ${tmpiso}/* ${tmplive}
sync

echo "creating persistence.conf"
echo "/ union" > ${tmppersistence}/persistence.conf

echo "installing grub"
grub-install --removable --target=x86_64-efi --boot-directory=${tmplive}/boot/ --efi-directory=${tmpefi} ${dev}

echo "installing syslinux"
dd bs=440 count=1 conv=notrunc if=/usr/lib/syslinux/mbr/gptmbr.bin of=${dev}
syslinux --install ${dev}2

echo "fixing isolinux folder/files"
mv ${tmplive}/isolinux ${tmplive}/syslinux
mv ${tmplive}/syslinux/isolinux.bin ${tmplive}/syslinux/syslinux.bin
mv ${tmplive}/syslinux/isolinux.cfg ${tmplive}/syslinux/syslinux.cfg

echo "fixing grub splash screen"
sed --in-place 's#isolinux/splash#syslinux/splash#' ${tmplive}/boot/grub/grub.cfg

echo "configuring persistence kernel parameter"
sed --in-place '0,/boot=live/{s/\(boot=live .*\)$/\1 persistence/}' ${tmplive}/boot/grub/grub.cfg ${tmplive}/syslinux/menu.cfg

echo "configuring default keyboard layout (german) and locales (primary en_US, secondary de_DE)"
sed --in-place '0,/boot=live/{s/\(boot=live .*\)$/\1 keyboard-layouts=de locales=en_US.UTF-8,de_DE.UTF-8/}' ${tmplive}/boot/grub/grub.cfg ${tmplive}/syslinux/menu.cfg

echo "cleaning up"
umount ${tmpall}
rmdir ${tmpall} ${tmp}

echo "sync'ing so that cached writes to USB stick are written"
sync

echo "USB stick is ready"
~~~

## Copying the Live Image

Plug in the new USB and inspect it:

~~~
$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 931.5G  0 disk
|-sda1   8:1    0   100M  0 part
|-sda2   8:2    0 393.5G  0 part
|-sda3   8:3    0   286M  0 part /boot
|-sda4   8:4    0     1K  0 part
|-sda5   8:5    0   1.9G  0 part [SWAP]
|-sda6   8:6    0  93.1G  0 part /
`-sda7   8:7    0 442.6G  0 part /usr/local
sdb      8:16   1   7.5G  0 disk
`-sdb1   8:17   1   7.5G  0 part /media/tbrowde/USB DISK
sr0     11:0    1  1024M  0 rom
~~~

~~~
$ sudo parted -s /dev/sdb print
Model: IS817 innostor (scsi)
Disk /dev/sdb: 8020MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      16.4kB  8020MB  8019MB  primary  fat32        lba
~~~

Copy the live image to the "master" USB (note the USB is *not*
mounted)


~~~
dd if=<image file> of=<device> bs=4M; sync
~~~

Took about seven minutes on my old laptop running Debian 8.

Duplicate the USB

mount both USBs, *then unmount them*
...

## Next Steps

I'm using these procedures to
build USBs for a course I'm
offering this fall:
+ Introduction to Computer Programming
