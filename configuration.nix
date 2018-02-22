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
  networking.hosts = {
    "127.0.0.1" = [ "knedlsepp.local" ];
  };
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
    chromium
    python36Packages.mps-youtube
    mpv
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.vim.defaultEditor = true;
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  powerManagement.enable = true;

  fonts.enableFontDir = true;
  fonts.enableCoreFonts = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [
    corefonts
    inconsolata
    liberation_ttf
    dejavu_fonts
    bakoma_ttf
    gentium
    ubuntu_font_family
    terminus_font
  ];
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

  services.journald.extraConfig = ''
    SystemMaxUse=300M
  '';
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "de, us";
  services.xserver.xkbOptions = "eurosign:e, ctrl:nocaps";

  # I prefer a cool lap
  services.mbpfan = {
    enable = true;
    lowTemp = 58;
    highTemp = 63;
    maxTemp = 86;
  };

  services.thermald.enable = true;

  # Enable touchpad support.
  services.xserver.synaptics = {
    enable = true;
    tapButtons = true;
    fingersMap = [ 1 0 0 ];
    buttonsMap = [ 1 3 2 ];
    accelFactor = "0.020";
    palmDetect = true;
    twoFingerScroll = true;
    vertTwoFingerScroll = true;
    maxSpeed = "20.0";
    additionalOptions = ''
      Option "VertScrollDelta" "-200"
      Option "HorizScrollDelta" "-300"
      Option "CoastingSpeed" "1.0"
    '';
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
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];
  hardware.bluetooth.enable = false;
  networking.enableB43Firmware = true;
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

 }

