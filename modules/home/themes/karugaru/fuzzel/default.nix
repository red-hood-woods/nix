{ config, lib, pkgs, ... }:

lib.mkIf config.nixtop.themes.karugaru.enable {
  home.packages = [ pkgs.fuzzel ];

  home.file.".config/fuzzel/fuzzel.ini".source =
    config.lib.file.mkOutOfStoreSymlink "${config.nixtop.themes.karugaru.repoPath}/modules/home/themes/karugaru/fuzzel/fuzzel.ini";
}
