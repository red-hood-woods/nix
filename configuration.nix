{ config, pkgs, ... }:

{
  # Bootloader & Networking
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "wonderland";
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
  networking.enableIPv6 = true; # Often helps with modern Intel WiFi stability

  systemd.oomd.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Fonts (Added fonts from your Sway config)
  fonts.packages = with pkgs; [
    poppins
    courier-prime
    font-awesome # Good fallback
    nerd-fonts.symbols-only
    nerd-fonts.fira-code

    nerd-fonts.jetbrains-mono
  ];

  # SwayFX System Module
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  # Steam & Flatpak
  programs.steam.enable = true;
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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
