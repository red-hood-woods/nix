{ config, pkgs, ... }:

{
  # Bootloader & Networking
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

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

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  system.stateVersion = "25.11"; # Updated!
}
