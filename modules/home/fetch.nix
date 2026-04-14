{ pkgs, lib, ... }:
{
  # Fastfetch/Hyfetch
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          right = 1;
        };
      };
      display = {
        separator = "";
      };
      modules = [
        {
          type = "title";
          keyWidth = 10;
        }
        "break"
        {
          type = "os";
          key = "╭─󱄅 OS ";
          keyColor = "34";
        }
        {
          type = "kernel";
          key = "├─󰒋 Kernel ";
          keyColor = "34";
        }
        {
          type = "packages";
          key = "├─󰏖 Pkg";
          keyColor = "34";
        }
        {
          type = "wm";
          key = "├─󱂬 WM ";
          keyColor = "34";
        }
        {
          type = "shell";
          key = "├─󱆃 Sh ";
          keyColor = "34";
        }
        {
          type = "terminal";
          key = "├─󰆍 Term ";
          keyColor = "34";
        }
        {
          type = "uptime";
          key = "╰─󰅐 Up ";
          keyColor = "34";
        }
        "break"
        "colors"
      ];
    };
  };
}