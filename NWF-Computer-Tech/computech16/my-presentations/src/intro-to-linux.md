title: VirtualBox   
<!-- insert-file headers.md -->

## Introduction to Linux

- Using VirtualBox for Windows

- From the schedule:

    1. Demo install of **Oracle's Virtual Box**.
    2. Install a Virtual Machine Image of **Ubuntu**.
    3. Take tour of **Ubuntu**'s features.

<!-- insert-file background.md -->

<!-- insert-file common-1.md -->

## Testing Linux Distros

Several methods

- VirtualBox

- Live CD/DVD

- Bootable USB drive

- Spare computer (native install; dual or single boot)

We'll use VirtualBox for this presentation

## The VirtualBox site

Note:

- the "Downloads" link
- the "End-user docs" link
- the "News Flash" section

The website
![50%](./pics/vbox-site.png)

## After selecting "Downloads"

![50%](./pics/vbox-dloads.png)


## Don't forget the "Extension Pack" (for USB 2/3; not distributable)

![50%](./pics/vbox-dloads-2.png)


## Upgrading or installing

When upgrading or installing, you lose network access temporarily.
You may have to uninstall an old version when upgrading.


## Selecting the Linux distro

Considerations (* recommended)

- amount of RAM (* 2 GB+)
- 32- or 64-bit (* 64-bit)
- 64-bit guest on 32-bit host? (NOT recommended)
- type network interface (remote access needed?)

## Installing the Linux guest...

.Creating a new Virtual Machine (VM)
![50%](./pics/vbox-01.png)

## Naming the VM

![50%](./pics/vbox-02.png)

## Choose RAM allocation

![50%](./pics/vbox-03.png)

## May need at least 1.5 Gb

![50%](./pics/vbox-05.png)

## Select "Next"

![50%](./pics/vbox-06.png)

## Creating a virtual hard disk

![50%](./pics/vbox-07.png)

## Use the default disk type (VDI)

![50%](./pics/vbox-08.png)

## Select "Next"

![50%](./pics/vbox-09.png)

## Choose "Dynamically allocated"

![50%](./pics/vbox-10.png)

## Normally accept the default name

![50%](./pics/vbox-11.png)

## Be generous selecting disk size

.Then select "Create"
![50%](./pics/vbox-12.png)

## The new VM appears in the list

![50%](./pics/vbox-13.png)

## More VM settings to be made

![50%](./pics/vbox-14.png)

## System options

![50%](./pics/vbox-15.png)

## Display options

.I normally choose 24 Mb
![50%](./pics/vbox-16.png)

## Attach the installation CD/DVD

![50%](./pics/vbox-17.png)

## Navigate to the location

![50%](./pics/vbox-18.png)

## Select the desired CD/DVD

![50%](./pics/vbox-19.png)

## Check the desired CD/DVD shows as attached

![50%](./pics/vbox-20.png)

## Now start the VM

![50%](./pics/vbox-21.png)

## Oops!

I made a typo on the guest name.  We can rename the host easily,
but we have to remove the disk and create a new one to rename it,
which is too complicated for me.  

The easiest thing to do is to start all over again and use the correct
spelling OR accept the misspelled hard disk name.

## After installation

After starting and finishing the installation, you'll want to install
"Guest Additions" to have the windowing and other features work well.

Please experiment and read the excellent documentation--there's much
more that can be done to tweak a host but this should get you started.


## Summary

- Today we have taken a look at getting a usable Linux installation for learning.

- If you find Linux useful, consider joining our local Linux user group.

- There is something out there in Linux land for nearly any interest.
  I encourage you to venture forth, have fun, and expand your
  knowledge and skills.

<!-- insert-file closer-help.md -->
