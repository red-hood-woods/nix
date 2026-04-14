{ config, pkgs, lib, ... }:

{
  # Bootloader & Networking
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "wonderland";
  networking.extraHosts = "127.0.0.1 wonderland";
  networking.networkmanager.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8192; # 8GB
    priority = 0;
  }];
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

 # Graphics & Hardware Acceleration (Intel Broadwell)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl

      # Vulkan Drivers
      vulkan-loader
      vulkan-validation-layers
      intel-compute-runtime
    ];
  };
  boot.initrd.kernelModules = [ "i915" ];
  hardware.enableAllFirmware = true;
  networking.enableIPv6 = true;

  systemd.oomd.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    poppins
    courier-prime
    font-awesome # Good fallback
    nerd-fonts.symbols-only
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts
    nerd-fonts.jetbrains-mono
  ];

  # SwayFX System Module
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  # Steam & Flatpak
  programs.steam.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.flatpak = {
    enable = true;
    # Automatically add the Flathub remote if it's missing
    remotes = lib.mkOptionDefault [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];
    # Declarative packages
    packages = [
      "app.twintaillauncher.ttl"

    ];
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.permittedInsecurePackages = [
    "python3.12-ecdsa-0.19.1"
  ];
  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
  };

  system.stateVersion = "25.11";
}
