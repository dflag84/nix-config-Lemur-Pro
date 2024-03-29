## Edit this configuration file to define what should be installed on
## your system.  Help is available in the configuration.nix(5) man page
## and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ## Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  ## Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  ## Enable swap on luks
  boot.initrd.luks.devices."luks-bcea4509-222b-434f-b4b1-d77c82590bae".device = "/dev/disk/by-uuid/bcea4509-222b-434f-b4b1-d77c82590bae";
  boot.initrd.luks.devices."luks-bcea4509-222b-434f-b4b1-d77c82590bae".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; ## Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  ## Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ## Enable networking
  networking.networkmanager.enable = true;
  
  ## Enable bluetooth
  hardware.bluetooth.enable = true;
  
  ## Enable S76 Hardware
  hardware.system76.enableAll = true;
  
  ## Enable FWUPD
  services.fwupd.enable = true;

  ## Set your time zone.
  time.timeZone = "America/Toronto";

  ## Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  ## Enable the X11 windowing system.
  services.xserver.enable = true;
  
  ## Enable Sway WM 
  #programs.sway.enable = true;

  ## Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  ## Enable the XFCE Desktop Environment.
  #services.xserver.desktopManager.xfce.enable = true;
  
  ## Enable the Gnome Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  ## Configure keymap in X11
  services.xserver = {
    layout = "ca";
    xkbVariant = "";
  };

  ## Configure console keymap
  console.keyMap = "cf";

  ## Enable CUPS to print documents.
  services.printing.enable = true;
  services.system-config-printer.enable = true;
  
  ## Enable Waydroid
  #virtualisation.waydroid.enable = true;

  ## Enable Flatpak
  ## For Theming Run:
  ## flatpak run --env=GTK_THEME=Breeze-Dark APP
  ## flatpak override --user --env=GTK_THEME=Breeze-Dark APP ## (to make it permanent)
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  ## Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    ## If you want to use JACK applications, uncomment this
    #jack.enable = true;

    ## use the example session manager (no others are packaged yet so this is enabled by default,
    ## no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  ## Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  ## Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dflag84 = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  ## Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ## List packages installed in system profile. To search, run:
  ## $ nix search wget
  environment.systemPackages = with pkgs; [
     vim ## Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     #libsForQt5.discover
     git
     kstars
     bash
     teams
     tdesktop
     ark
     firefox
     vivaldi
     brave
     libsForQt5.falkon
     kate
     libsForQt5.kwrited
     okular
     libsForQt5.kasts
     hypnotix
     libsForQt5.neochat
     gnome.gnome-disk-utility
     libsForQt5.plasma-disks
     freecad
     thunderbird
     organicmaps
     libsForQt5.kweather
     libsForQt5.audiotube
     libsForQt5.plasmatube
     onlyoffice-bin
     pmbootstrap
     bottles
     libsForQt5.marble
     libsForQt5.angelfish
     libreoffice-qt
     libsForQt5.index
     #libreoffice
     brave
     digikam
     nxpmicro-mfgtools
     ocamlPackages.dose3
     python3Full
     popsicle
     spotify
     qelectrotech
     libsForQt5.kdevelop-unwrapped
     #jetbrains.clion
     freetube
     mepo
     libsForQt5.buho
     libsForQt5.plasma-systemmonitor
     libsForQt5.kdeconnect-kde
     kalendar
     #rPackages.pulsar
     #calligra
     ##Gnome Extensions##
     #gnomeExtensions.appindicator
     #gnomeExtensions.just-perfection
     #gnome.gnome-tweaks
  ];

  ## Some programs need SUID wrappers, can be configured further or are
  ## started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  ## Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ## List services that you want to enable:

  ## Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  ## Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  ## Or disable the firewall altogether.
  networking.firewall.enable = false;

  ## This value determines the NixOS release from which the default
  ## settings for stateful data, like file locations and database versions
  ## on your system were taken. It‘s perfectly fine and recommended to leave
  ## this value at the release version of the first install of this system.
  ## Before changing this value read the documentation for this option
  ## (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
