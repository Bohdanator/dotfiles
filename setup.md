# Setup Guide

Tip: there is no scrollback on tty. You can use `screen` or `tee` to preserve the output of a
command.

Tip: You can use `nmtui` to connect to a wireless network from the command line easily.

## Installation

This part follows the
[official installation guide](https://wiki.archlinux.org/index.php/Installation_guide),
consult it in case of doubt.

This guide assumes an installation of Windows 10 (on GPT & UEFI) on the same disk and results in
a working dual-boot system.

1. acquire an installation image, prepare an installation medium and boot the live environment
1. verify the boot mode by running `ls /sys/firmware/efi/efivars` (should print something without
   an error)
1. make sure you are connected to the internet
1. `timedatectl set-ntp true`
1. create a partition for the root directory (we will call it `/dev/yourRoot`) and format it
   (eg. `mkfs.ext4 /dev/yourRoot`)
   - run `sudo parted` and type `align-check optimal x` with proper `x`
1. `mount /dev/yourRoot /mnt`
1. `mkdir /mnt/efi` and `mount /dev/yourESP /mnt/efi`
1. `pacstrap /mnt base base-devel linux linux-firmware intel-ucode networkmanager sudo nano git`
   - replace `intel-ucode` by `amd-ucode` (if you have an AMD CPU) and the `linux` package by
     `linux-lts` (if you wish)
1. `genfstab -U /mnt >> /mnt/etc/fstab`
1. `arch-chroot /mnt`
1. `ln -sf /usr/share/zoneinfo/yourRegion/yourCity /etc/localtime`
1. `hwclock --systohc`
1. uncomment `en_US.UTF-8 UTF-8` and other needed locales in `/etc/locale.gen` and run `locale-gen`
1. `echo 'LANG=en_US.UTF-8' > /etc/locale.conf`
1. `echo yourHostname > /etc/hostname`
1. create `/etc/hosts` with this content:
   ```
   127.0.0.1	localhost
   ::1		localhost
   127.0.1.1	yourHostname
   ```
1. install GRUB
   1. `pacman -Syu grub efibootmgr os-prober ntfs-3g`
   1. `grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB`
   1. `mkdir /mnt/windows` and `mount /dev/yourWindowsPartition /mnt/windows`
   1. `grub-mkconfig -o /boot/grub/grub.cfg`
   1. `umount /mnt/windows`
1. set root password with `passwd`
1. `useradd -m -G wheel yourUsername`
1. `passwd yourUsername`
1. `echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/10-install`
1. exit and reboot

## Post-installation
1. `sudo systemctl enable --now NetworkManager` and make sure you are connected to the internet
1. `timedatectl set-ntp true`
1. set up Pacman and Yay
   1. uncomment `Color` and the `[multilib]` section in `/etc/pacman.conf`
   1. `mkdir builds`
   1. `cd builds`
   1. `git clone https://aur.archlinux.org/yay-bin.git`
   1. `cd yay-bin`
   1. `makepkg -si`
   1. `cd ~`
1. set up dotfiles and install software
   1. `git clone` this dotfiles repository
   1. `cd ~/dotfiles`
   1. `cat packages/official.txt | xargs -ot sudo pacman -Syu --needed`
   1. `cat packages/aur.txt | xargs -ot yay -Syu`
   1. we are going to use GNU Stow to create symlinks
      ([a tutorial](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)),
      but we need to clone the directory structure first
      1. `rsync -a --include '*/' --exclude '*' stow/ ~`
      1. `stow stow`
   1. `sudo usermod -aG docker,wireshark $USER`
   1. `sudo systemctl enable cronie cups docker fstrim.timer lightdm tlp ufw`
   1. `sudo ufw enable`
   1. `chsh -s /bin/zsh`
   1. set `greeter-setup-script=/usr/bin/numlockx on` in `/etc/lightdm/lightdm.conf`
   1. `cat templates/etc/lightdm/lightdm-gtk-greeter.conf | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf`
   1. copy files in the `templates` directory to `~` and edit them appropriately
1. reboot

Note: If you encounter black screen with no tty instead of LightDM startup on a system with Intel
graphics, try to uninstall `xf86-video-intel`. If the problem vanishes, try to install it back and
set `MODULES=(i915)` in `/etc/mkinitcpio.conf` and run `mkinitcpio -P` - this should solve the
issue.

## Enable swap and hibernation
   1. `yay -Syu hibernator`
   1. `sudo hibernator 8G` (or other size)
      - You may need to run `grub-mkconfig -o /boot/grub/grub.cfg` manually afterwards.
   1. `echo vm.swappiness=20 | sudo tee /etc/sysctl.d/99-swappiness.conf`
   1. reboot and check if everything works (consult eg.
      [this tutorial](https://confluence.jaytaala.com/display/TKB/Use+a+swap+file+and+enable+hibernation+on+Arch+Linux+-+including+on+a+LUKS+root+partition)
      in case of problems)

## Last steps
1. go through app settings
   - especially don't forget to tweak settings of the XFCE Power Manager
1. `cat packages/vscode.txt | xargs -otn 1 code --install-extension`
1. run `ssh-keygen` and `ssh-copy-id` the public key to all relevant SSH servers
1. visit `http://localhost:631` and install your printers
   - you may need to enter the printer's URL manually, eg. it's `lpd://192.168.1.1/LPRServer` or
     `ipp://192.168.1.1/printers/ml-1520` for me, with the `Series` driver
1. set a wallpaper with Nitrogen
1. test everything thoroughly (eg. sound/headphones/microphone, bluetooth, media keys, online screen
   sharing, ...)
1. create a backup (eg. with Timeshift)
1. Enjoy!
