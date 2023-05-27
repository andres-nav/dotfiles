# modules/themes/alucard/default.nix --- a regal dracula-inspired theme

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.theme;
in {
  config = mkIf (cfg.active == "alucard") (mkMerge [
    # Desktop-agnostic configuration
    {
      modules = {
        theme = {
          wallpaper = mkDefault ./../wallpapers/0007.png;

          gtk = {
            theme = "Dracula";
            iconTheme = "Paper";
            cursorTheme = "Paper";
          };
          fonts = {
            sans.name = "Fira Sans";
            mono.name = "Fira Code";
          };
          colors = {
            black         = "#1E2029";
            red           = "#ffb86c";
            green         = "#50fa7b";
            yellow        = "#f0c674";
            blue          = "#61bfff";
            magenta       = "#bd93f9";
            cyan          = "#8be9fd";
            silver        = "#e2e2dc";
            grey          = "#5B6268";
            brightred     = "#de935f";
            brightgreen   = "#0189cc";
            brightyellow  = "#f9a03f";
            brightblue    = "#8be9fd";
            brightmagenta = "#ff79c6";
            brightcyan    = "#0189cc";
            white         = "#f8f8f2";

            types.fg      = "#bbc2cf";
            types.panelbg = "#21242b";
            types.border  = "#1a1c25";
          };
        };

        desktop.browsers = {
          firefox.userChrome = concatMapStringsSep "\n" readFile [
            ./config/firefox/userChrome.css
          ];
          qutebrowser.userStyles = concatMapStringsSep "\n" readFile
            (map toCSSFile [
              ./config/qutebrowser/userstyles/monospace-textareas.scss
              ./config/qutebrowser/userstyles/stackoverflow.scss
              ./config/qutebrowser/userstyles/xkcd.scss
            ]);
        };
      };
    }

    # Desktop (X11) theming
    (mkIf config.services.xserver.enable {
      user.packages = with pkgs; [
        unstable.dracula-theme
        paper-icon-theme # for rofi
      ];

      # Other dotfiles
      home.configFile = with config.modules; mkMerge [
        {
          "wallpapers" = { source = ./../wallpapers; recursive = true; };
        }
        {
          # Sourced from sessionCommands in modules/themes/default.nix
          "xtheme/90-theme".source = ./config/Xresources;
        }
        (mkIf desktop.bspwm.enable {
          #"bspwm/rc.d/95-polybar".source = ./config/polybar/run.sh;
        })
        (mkIf desktop.apps.rofi.enable {
          "rofi/theme" = { source = ./config/rofi; recursive = true; };
        })
        (mkIf (desktop.bspwm.enable || desktop.stumpwm.enable) {
          "Dracula-purple-solid-kvantum" = {
            recursive = true;
            source = "${pkgs.unstable.dracula-theme}/share/themes/Dracula/kde/kvantum/Dracula-purple-solid";
            target = "Kvantum/Dracula-purple-solid";
          };
          "kvantum.kvconfig" = {
            text = "theme=Dracula-purple-solid";
            target = "Kvantum/kvantum.kvconfig";
          };
        })
        (mkIf desktop.browsers.qutebrowser.enable {
          "qutebrowser/extra/theme.py".source = ./config/qutebrowser/theme.py;
        })
      ];
    })
  ]);
}
