# greetd session using tuigreet, no compositor session needed for the greeter itself
{ lib, pkgs, unstable-pkgs, config, ... }:
let
  cfg = config.programs.tuigreet-greeter;
in {
  options.programs.tuigreet-greeter.enable = lib.mkEnableOption "greetd session using tuigreet";

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.terminal.vt = 1;
      settings.default_session.command =
        "${lib.getExe pkgs.greetd.tuigreet} --time --remember --remember-session --asterisks --cmd ${lib.getExe unstable-pkgs.mango}";
    };
  };
}
