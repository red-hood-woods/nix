{ pkgs, lib, ... }:
{
  # Foot :p
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Courier Prime:size=11";
      };
      colors = {
        alpha = 0.8;
        background = "121212";
      };
    };
  };
}