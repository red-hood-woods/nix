{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.avim.packages.${pkgs.system}.default
  ];
}