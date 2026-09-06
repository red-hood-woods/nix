{ pkgs, lib, config, unstable-pkgs, ... }:

lib.mkIf config.nixtop.themes.karugaru.enable {
  xdg.configFile."mango/config.conf".text = ''
    env=XDG_CURRENT_DESKTOP,mango
    exec-once=dbus-update-activation-environment --systemd --all
    exec-once=${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    source=~/.config/mango/karugaru.conf
  '';

  home.file.".config/mango/karugaru.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.nixtop.themes.karugaru.repoPath}/modules/home/themes/karugaru/mango/karugaru.conf";

  # matugen's output, seed a writable copy (store symlinks block its writes)
  home.activation.ensureKarugaruFlutterice = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p $HOME/.config/mango
    $DRY_RUN_CMD [ -e "$HOME/.config/mango/flutterice.conf" ] || $DRY_RUN_CMD touch "$HOME/.config/mango/flutterice.conf"
  '';

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.mango = {
      default = [ "gtk" "gnome" ];
      "org.freedesktop.impl.portal.Access" = [ "gtk" ];
      "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
    };
    extraPortals = [
      pkgs.gnome-keyring
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  home.packages = with pkgs; [
    swaybg
    swaylock
    grim
    slurp
    unstable-pkgs.mango
  ];
}
