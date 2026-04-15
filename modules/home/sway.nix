{ pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    package = pkgs.swayfx;

    # Native Home Manager Sway Configuration
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      bars = [];
      fonts = {
        names = [ "Courier Prime" ];
        size = 11.0;
      };
      # Output displays
      output = {
        "HDMI-A-1" = { pos = "0 0"; };
        "eDP-1" = { pos = "1680 0"; };
        "*" = {
          bg = "/home/alice/.bg.jpg fill";
        };
      };

      # Touchscreen Input
      input = {
        "3823:49229:eGalax_Inc._eGalaxTouch_EXC3000-0367-46.00.00" = {
          map_to_output = "eDP-1";
        };
      };
      # Autostart applications
      startup = [
        { command = "mako"; always = false; }
      ];

      # Border styling and Window Rules
      window = {
        border = 3;
	titlebar = false;
        commands = [
          { command = "floating enable, focus"; criteria = { app_id = "(?i)eog|sxiv|feh|mpv|vlc|file-roller|xarchiver"; }; }
          { command = "floating enable, focus"; criteria = { class = "(?i)eog|sxiv|feh|mpv|vlc|file-roller|xarchiver"; }; }
          { command = "floating enable"; criteria = { window_role = "dialog"; }; }
          { command = "floating enable"; criteria = { window_role = "pop-up"; }; }
          { command = "floating enable"; criteria = { window_type = "dialog"; }; }
          { command = "floating enable"; criteria = { window_type = "menu"; }; }
          { command = "floating enable"; criteria = { app_id = "thunar"; title = "File Operation Progress"; }; }
          { command = "floating enable, sticky enable, focus"; criteria = { app_id = "thunar"; title = "Confirm to replace files"; }; }
        ];
      };

      floating = {
        border = 3;
        modifier = modifier;
      };

      gaps = {
        smartGaps = false;
      };

      # Theming
      colors = {
        focused = { border = "#8b0000"; background = "#8b0000"; text = "#ffffff"; indicator = "#4b0000"; childBorder = "#8b0000"; };
        focusedInactive = { border = "#2e0000"; background = "#2e0000"; text = "#a68a8f"; indicator = "#2e0000"; childBorder = "#2e0000"; };
        unfocused = { border = "#1a1a1a"; background = "#1a1a1a"; text = "#6e5a5e"; indicator = "#1a1a1a"; childBorder = "#1a1a1a"; };
        urgent = { border = "#ff0000"; background = "#ff0000"; text = "#ffffff"; indicator = "#ff0000"; childBorder = "#ff0000"; };
        placeholder = { border = "#1a1a1a"; background = "#1a1a1a"; text = "#ffffff"; indicator = "#1a1a1a"; childBorder = "#1a1a1a"; };
        background = "#121212";
      };

      # Keybindings
      keybindings = let
        alt = "Mod1";
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec foot";
        "${modifier}+d" = "exec rofi -show drun";
        "${modifier}+k" = "exec $HOME/.local/bin/wl-kaomoji";
        "${modifier}+Shift+d" = "exec rofi -show run";
        "${modifier}+Shift+c" = "reload";

        "Print" = "exec grim -g \"$(slurp)\" ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png";
        "${modifier}+l" = "exec swaylock --image ~/.lock.png --scaling fill --ring-color f6a6aa --key-hl-color 1c262c --text-color f2d7d8";
        "${modifier}+w" = "exec vivaldi";
        "${modifier}+e" = "exec foot -e yazi";
        "${modifier}+m" = "exec foot -e ncmpcpp";
        "${modifier}+n" = "exec mpv --player-operation-mode=pseudo-gui";

        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

        "${modifier}+c" = "kill";
        "${alt}+F4" = "kill";

        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+s" = "layout toggle split";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+space" = "floating toggle";
        "${modifier}+Shift+space" = "focus mode_toggle";

        "${modifier}+Control+Right" = "workspace next";
        "${modifier}+Control+Left" = "workspace prev";
        "${modifier}+1" = "workspace 1:I";
        "${modifier}+2" = "workspace 2:II";
        "${modifier}+3" = "workspace 3:III";
        "${modifier}+4" = "workspace 4:IV";
        "${modifier}+5" = "workspace 5:V";
        "${modifier}+6" = "workspace 6:VI";

        "${modifier}+Shift+1" = "move container to workspace 1:I";
        "${modifier}+Shift+2" = "move container to workspace 2:II";
        "${modifier}+Shift+3" = "move container to workspace 3:III";
        "${modifier}+Shift+4" = "move container to workspace 4:IV";
        "${modifier}+Shift+5" = "move container to workspace 5:V";
        "${modifier}+Shift+6" = "move container to workspace 6:VI";

        "${modifier}+BackSpace" = "exec swaymsg reload";
        "${modifier}+q" = "exec swaynag -t warning -m 'Really exit?' -b 'Yes' 'swaymsg exit'";
        "${modifier}+r" = "mode resize";
      };

      # Resize Mode
      modes = {
        resize = {
          Left = "resize shrink width 5 px or 5 ppt";
          Down = "resize grow height 5 px or 5 ppt";
          Up = "resize shrink height 5 px or 5 ppt";
          Right = "resize grow width 5 px or 5 ppt";
          Return = "mode default";
          Escape = "mode default";
	};
      };
     };
     extraConfig = ''
       blur enable
       blur_passes 2
       blur_radius 3
   '' ;
  };
}