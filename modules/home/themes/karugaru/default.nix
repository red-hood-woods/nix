# mango + mangobar + fuzzel + mako, matugen-themed, no quickshell
{ config, lib, pkgs, ... }: {
  options.nixtop.themes.karugaru.enable = lib.mkEnableOption "Karugaru Theme (MangoWC, no Quickshell)";
  options.nixtop.themes.karugaru.repoPath = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/nix";
    description = "Where this repo is cloned, used for out-of-store symlinks.";
  };

  imports = [
    ./mango
    ./mangobar
    ./fuzzel
    ./mako
  ];

  config = lib.mkIf config.nixtop.themes.karugaru.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Everforest-Dark-B";
        package = pkgs.everforest-gtk-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      gtk4.theme = null;
    };

    home.pointerCursor = {
      enable = true;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
      gtk.enable = true;
    };
  };
}
