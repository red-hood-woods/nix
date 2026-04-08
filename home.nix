{ config, pkgs, ... }:

{
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.packages = with pkgs; [
    # Your requested apps
    vivaldi emacs w3m git prismlauncher mpv feh discord yazi playerctl libnotify unzip p7zip
    thunar python3 wine renpy tor-browser-bundle-bin transmission_4-gtk
    krita weechat nicotine-plus fastfetch btop npm neovim wl-clipboard
    jdk8 jdk25 ghc stack cabal-install haskell-language-server wget curl gvfs
    
    # Utilities from your Sway config
    swaybg          # Wallpaper
    mako            # Notifications
    rofi-wayland    # App launcher (replaces rofi for Wayland)
    grim slurp      # Screenshots
    swaylock        # Lockscreen
    brightnessctl   # Brightness keys
    pulseaudio      # For 'pactl' volume commands
    capitaine-cursors
  ];

  # This links your existing file into the Nix system
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    extraConfig = builtins.readFile ./sway.conf; 
  };

  # Cursor theme setup
  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
    gtk.enable = true;
  };

  services.mpd.enable = true;
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
