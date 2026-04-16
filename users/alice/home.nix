{ config, pkgs, lib, inputs,  unstable-pkgs, ... }:

{
  imports = [
    "${inputs.self}/modules/home/sway.nix"
    "${inputs.self}/modules/home/foot.nix"
    "${inputs.self}/modules/home/fetch.nix"
    "${inputs.self}/modules/home/nixvim.nix"
    "${inputs.self}/modules/home/spacemacs.nix"
  ];
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.packages = with pkgs; [
    # Misc
    vivaldi w3m tor-browser # Browsers
    xfce.mousepad xfce.thunar # Xfce Carryover
    foot # Terminal Emulator's
    fastfetch hyfetch # Fetch
    yazi tmux chafa libsixel ripgrep btop # Terminal things
    transmission_4-gtk nicotine-plus # Legal things
    vscodium stack obsidian # Idk i don rembere
    krita gimp # Photo editing
    cinny-desktop iamb weechat # Non Discord chat

    # Pgm
    jdk25
    ghc
    cabal-install 
    haskell-language-server 
    python3
    nodejs
    
    # Media
    mpv
    ncmpcpp
    cava
    ffmpeg
    ffmpegthumbnailer
    feh

    # Gaming/Emu
    bottles
    wine
    renpy
    discord
    obs-studio
    prismlauncher

    # Utilities
    swaybg          # Wallpaper
    libnotify mako  # Notifications
    rofi            # App launcher
    grim slurp      # Screenshots
    swaylock        # Lockscreen
    brightnessctl   # Brightness keys
    wl-clipboard    # Clipboard
    playerctl gvfs
    pulseaudio      # For 'pactl' volume commands
    capitaine-cursors # Curosor
    git # Its git
    unzip p7zip     # The zippers
    wget curl # -.-

    # Unstable
    unstable-pkgs.ani-cli
    unstable-pkgs.antigravity #AI Tool
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
