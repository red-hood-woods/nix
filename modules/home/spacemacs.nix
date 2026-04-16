{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.nixmacs.packages.${pkgs.system}.default
  ];
}
