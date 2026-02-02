{ config, lib, pkgs, ... }:

let
  cfg = config.my.webapps;

  mkWebApp = slug: app:
    let
      appName = app.name or lib.strings.capitalize slug;
      wmClass = "webapp-${slug}";
      iconPath = ".local/share/icons/${slug}.png";

      exec = lib.concatStringsSep " " (
        [
          "${pkgs.brave}/bin/brave"
          "--app=${app.url}"
          "--class=${wmClass}"
        ]
        ++ (app.extraFlags or [])
      );
    in {
      name = appName;
      comment = "Web Application launched via Brave";
      exec = exec;
      icon = slug;
      terminal = false;
      categories = app.categories or [ "Network" "WebBrowser" ];
      startupWMClass = wmClass;
    };
in {
  options.my.webapps = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        url = lib.mkOption {
          type = lib.types.str;
          description = "Web app URL";
        };

        name = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
        };

        iconUrl = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Remote PNG/SVG icon URL";
        };

        categories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "Network" "WebBrowser" ];
        };

        extraFlags = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          description = "Extra Brave flags";
        };
      };
    });
    default = {};
  };

  config = lib.mkIf (cfg != {}) {

    programs.brave.enable = true;

    # Desktop entries (script → .desktop file)
    xdg.desktopEntries = lib.mapAttrs mkWebApp cfg;

    # Icons (script → curl + ~/.local/share/icons)
    home.file = lib.mapAttrs'
      (slug: app:
        lib.optionalAttrs (app.iconUrl != null) {
          name = ".local/share/icons/${slug}.png";
          value.source = pkgs.fetchurl {
            url = app.iconUrl;
            sha256 = lib.fakeSha256;
          };
        }
      )
      cfg;
  };
}
