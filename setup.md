# Setup Guide

Tip: there is no scrollback on tty. You can use `screen` or `tee` to preserve the output of a command.

## Installation

This part follows the [official installation guide](https://wiki.archlinux.org/index.php/Installation_guide), consult it in case of doubt.

This guide assumes an installation of Windows 11 (on GPT & UEFI) on the same disk and results in a working dual-boot system (though you might need to toggle Secure Boot when switching the OS).

1. acquire an installation image, prepare an installation medium and boot the live environment
1. verify the boot mode by running `ls /sys/firmware/efi/efivars` (should print something without an error)
1. make sure you are connected to the internet (`iwctl` -> `station wlan0 connect yourSSID`)
1. `timedatectl set-ntp true`
1. create an empty partition for the root directory (we will call it `/dev/nvme0n1pX`)
   - run `parted /dev/nvme0n1` and type `align-check optimal x` with proper `x`
1. `cryptsetup --type luks1 -y -v luksFormat /dev/nvme0n1pX`
1. `cryptsetup open /dev/nvme0n1pX root`
1. `mkfs.ext4 /dev/mapper/root`
1. `mount /dev/mapper/root /mnt`
1. `mkdir /mnt/efi` and `mount /dev/yourESP /mnt/efi`
1. `pacstrap /mnt base base-devel linux linux-firmware intel-ucode networkmanager sudo nano git xdg-user-dirs`
   - you can replace `intel-ucode` by `amd-ucode` (if you have an AMD CPU) and the `linux` package by `linux-lts` (if you wish)
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
1. add a LUKS keyfile (so that you don't have to type the disk password twice when booting)
   1. `dd bs=512 count=4 if=/dev/random of=/crypto_keyfile.bin iflag=fullblock`
   1. `chmod 600 /crypto_keyfile.bin`
   1. `cryptsetup luksAddKey /dev/nvme0n1pX /crypto_keyfile.bin`
1. update `/etc/mkinitcpio.conf`:
   1. add `/crypto_keyfile.bin`to the `FILES` list
   1. add `encrypt` between `block` and `filesystems` in the `HOOKS` list
   1. save and run `mkinitcpio -P`
1. install GRUB:
   1. `pacman -Syu grub efibootmgr`
   1. modify `/etc/default/grub`:
      1. set `GRUB_TIMEOUT=1`
      1. add `zswap.enabled=0` to `GRUB_CMDLINE_LINUX_DEFAULT` (so that it doesn't interfere with zram that will be installed later)
      1. add `cryptdevice=UUID=yourDeviceUUID:root:allow-discards root=/dev/mapper/root` to `GRUB_CMDLINE_LINUX_DEFAULT` (you can find out the right `yourDeviceUUID` value e.g. by running `blkid /dev/nvme0n1pX -s UUID`)
      1. uncomment `GRUB_ENABLE_CRYPTODISK=y`
      1. all other modifications that are needed - see Device-specific notes below
   1. `grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB`
   1. `grub-mkconfig -o /boot/grub/grub.cfg`
1. set root password with `passwd`
1. `useradd -m -G wheel yourUsername`
1. `passwd yourUsername`
1. `echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/10-install`
1. exit and reboot

## Post-installation

1. `xdg-user-dirs-update`
1. `sudo systemctl enable --now NetworkManager` and make sure you are connected to the internet
1. `sudo timedatectl set-ntp true`
1. set up pacman and yay
   1. uncomment `Color`, `VerbosePkgLists`, `ParallelDownloads` and the `[multilib]` section in `/etc/pacman.conf`
   1. `mkdir builds`
   1. `cd builds`
   1. `git clone https://aur.archlinux.org/yay-bin.git`
   1. `cd yay-bin`
   1. `makepkg -si`
   1. `cd ~`
1. set up dotfiles and install software
   1. `cd Documents` and `git clone` this dotfiles repository
   1. `cd dotfiles`
   1. `cat packages/official.txt | xargs -ot sudo pacman -Syu --needed`
   1. `cat packages/aur.txt | xargs -ot yay -Syu`
   1. `chezmoi init --apply -v -S ./chezmoi`
   1. `sudo usermod -aG docker,wireshark,nix-users $USER`
   1. `sudo systemctl enable bluetooth cronie cups docker fstrim.timer greetd nix-daemon thermald tlp ufw`
   1. `sudo ufw enable`
   1. `chsh -s /bin/zsh`
   1. copy files from `~/.root-src` where they belong (use `diff` to compare them with the system-provided files if they are present)
      - you can use `sudo rsync -rv ~/.root-src/ /` to copy all the files at once
   1. `rustup default stable`
   1. `nix-channel --add https://nixos.org/channels/nixpkgs-unstable && nix-channel --update`
   1. `cat packages/vscode.txt | xargs -otn 1 code --install-extension`
   1. `ln -s /usr/share/hunspell/* ~/.config/Code/Dictionaries`
1. disable unsuccessful login delay by adding `nodelay` to the end of the `auth [success=1 default=bad] pam_unix.so try_first_pass nullok` line in `/etc/pam.d/system-auth`
1. reboot

## Last steps

1. Windows:
   1. check that your Windows system works as expected
   1. turn off hibernation and fast startup
   1. configure Windows to store time in UTC - run this in Administrator Command Prompt: `reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f`
1. run `ssh-keygen -t ed25519` and `ssh-copy-id` the public key to all relevant SSH servers
1. set your wallpaper by creating an image file/symlink `~/wallpaper`
1. visit `http://localhost:631` and install your printers
1. go through app settings
   - don't forget to check TLP settings
   - When setting up Firefox:
     - set `media.ffmpeg.vaapi.enabled=true` in `about:config` to enable hardware accelereation
     - I recommend using the uBlock Origin extension and adding these filter lists:
       - `uBlock filters – Annoyances`
       - `EasyList – Annoyances`
       - `CZE, SVK: EasyList Czech and Slovak`
1. test everything thoroughly (eg. sound/headphones/microphone, bluetooth, media keys, online screen
   sharing, ...)

---

## Device-specific notes

- My keyboard is not detected after booting. To resolve this, try to add `i8042.dumbkbd=1` to the end of `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub` in between grub-install and grub-mkconfig (CapsLock/... indicators won't work though).

- If you encounter black screen with no tty instead of login manager startup on a system with Intel graphics, try to uninstall `xf86-video-intel`. If the problem vanishes, install it back, set `MODULES=(i915)` in `/etc/mkinitcpio.conf` and run `mkinitcpio -P` - this should solve the issue.

- When adding a printer, you may need to enter the printer's URL manually, eg. it's `lpd://192.168.1.1/LPRServer` or `ipp://192.168.1.1/printers/ml-1520` for me, with the `Series` driver.
