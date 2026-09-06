{ config, lib, ... }:
{
  config = lib.mkIf config.nixtop.themes.karugaru.enable {
    services.mangobar = {
      enable = true;
      systemdTarget = "mango.target";
      configFile = ./config.jsonc;
    };

    # style.css is matugen's, not Home Manager's - seed a writable file
    # so mangobar has something to read before the first matugen run
    home.activation.ensureKarugaruMangobarStyle = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p $HOME/.config/mangobar
      $DRY_RUN_CMD [ -e "$HOME/.config/mangobar/style.css" ] || $DRY_RUN_CMD touch "$HOME/.config/mangobar/style.css"
    '';
  };
}
