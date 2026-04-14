{ config, pkgs, lib, inputs,  unstable-pkgs, ... }:

{
  imports = [
    "${inputs.self}/modules/home/sway.nix"
    "${inputs.self}/modules/home/foot.nix"
    "${inputs.self}/modules/home/fetch.nix"
    "${inputs.self}/modules/home/nixvim.nix"
  ];
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.packages = with pkgs; [
    vivaldi emacs w3m mpv prismlauncher feh discord yazi playerctl libnotify unzip p7zip
    chafa tmux unstable-pkgs.ani-cli libsixel ripgrep vscodium ffmpegthumbnailer foot xfce.thunar python3 wine renpy tor-browser transmission_4-gtk
    krita gimp git nodejs weechat nicotine-plus fastfetch ffmpeg obs-studio btop wl-clipboard xfce.mousepad
    jdk25 ghc ncmpcpp stack obsidian cava cabal-install haskell-language-server wget curl gvfs hyfetch

    # Utilities
    swaybg          # Wallpaper
    mako            # Notifications
    rofi            # App launcher
    grim slurp      # Screenshots
    swaylock        # Lockscreen
    brightnessctl   # Brightness keys
    pulseaudio      # For 'pactl' volume commands
    capitaine-cursors # Curosor
  ];

  # Cursor theme setup
  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
    gtk.enable = true;
  };
  # MPD
  services.mpd = {
    enable = true;
    musicDirectory = "/home/alice/Music";
  };

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
