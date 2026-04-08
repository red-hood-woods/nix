{ config, pkgs, ... }:

{
  # Bootloader & Networking
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "wonderland";
  networking.networkmanager.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd"; # High compression ratio, very fast
    memoryPercent = 50;  # Use up to 50% of your RAM for the compressed area
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8192; # 8GB
    priority = 0; # Lower than zRAM's default of 5, so disk is used last
  }];

  # Audio (Replaces the need for 'exec pipewire' in your config)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Graphics & Portals (Intel Broadwell)
  hardware.graphics.enable = true;
  systemd.oomd.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Fonts (Added fonts from your Sway config)
  fonts.packages = with pkgs; [
    ionicons
    poppins
    courier-prime
    font-awesome # Good fallback
    nerd-fonts.symbols-only # Great if you just want icons
    nerd-fonts.fira-code    # Example: FiraCode with icons built-in
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

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  system.stateVersion = "25.11"; # Updated!
}
