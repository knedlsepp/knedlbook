# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "knedlbook"; # Define your hostname.
  networking.networkmanager.enable = true;

   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "de";
     defaultLocale = "de_AT.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    firefox
    gitAndTools.gitFull
    gparted
    sublime3
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.vim.defaultEditor = true;
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us, de";
  services.xserver.xkbOptions = "eurosign:e, caps:swapescape";

  # Enable touchpad support.
  services.xserver.synaptics = {
    enable = true;
    accelFactor = "0.003";
    palmDetect = true;
    twoFingerScroll = true;
    maxSpeed = "3.0";
  }; 
  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  nixpkgs.config.allowUnfree = true; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.sepp= {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"];
    uid = 1000;
    initialPassword = "sepp";
  };

  hardware.enableRedistributableFirmware = true;
  hardware.pulseaudio.enable = true;
  networking.enableB43Firmware = true;
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

 }

