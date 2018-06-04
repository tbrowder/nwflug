title: Creating a Bootable USB - Part 1
<!-- insert-file headers.md -->
date: 2018-03-05

## Objectives

Part 1

+ Create a bootable USB with a simple copy
+ Duplicate the USB

Part 2

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
mounted):


~~~
# dd if=<image file> of=<device> bs=4M; sync
~~~

Took about seven minutes on my old laptop running Debian 8.

Duplicate the master USB on another USB


mount both USBs, *then unmount them*
...

~~~
dd if=/dev/sdb of=/dev/sdc bs=4M; sync
~~~

Took about twenty minutes on my old laptop running Debian 8.

## Next Steps

I'm using these procedures to
build USBs for a course I'm
offering this fall:

+ Introduction to Computer Programming for Seniors
