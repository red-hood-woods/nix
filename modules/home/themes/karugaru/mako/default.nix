{ config, lib, pkgs, ... }:

lib.mkIf config.nixtop.themes.karugaru.enable {
  services.mako.enable = lib.mkForce false;
  home.packages = [ pkgs.mako ];

  home.activation.ensureKarugaruMako = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p $HOME/.config/mako
    $DRY_RUN_CMD [ -e "$HOME/.config/mako/config" ] || $DRY_RUN_CMD touch "$HOME/.config/mako/config"
  '';
}
