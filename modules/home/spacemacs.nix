{ config, pkgs, inputs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable-pgtk; 
  };

  home.file.".emacs.d" = {
    source = inputs.spacemacs-repo;
    recursive = true;
  };
}