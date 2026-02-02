{ config, lib, pkgs, ... }:

let
  cfg = config.my.webapps;

  # Fetch homarr-labs dashboard-icons ONCE
  dashboardIcons = pkgs.fetchFromGitHub {
    owner = "homarr-labs";
    repo = "dashboard-icons";

    # pinned commit (from your prefetch output)
    rev = "94573aeb16fbce590ac1b7a4aa9a9501c1f99296";

    # correct hash (base64 form)
    hash = "sha256-Jw4OcWyEzhewxB8q+4zWDVqz09mZpGY/u3xkKzWCpqM=";
  };

  mkWebApp = slug: app:
    let
      appName =
        if app.name != null
        then app.name
        else lib.strings.capitalize slug;

      wmClass = "webapp-${slug}";

      exec = lib.concatStringsSep " " (
        [
          "${pkgs.brave}/bin/brave"
          "--app=${app.url}"
          "--class=${wmClass}"
        ]
        ++ app.extraFlags
      );
    in {
      name = appName;
      comment = "Web Application launched via Brave";
      exec = exec;
      icon = slug;
      terminal = false;
      categories = app.categories;

      # current Home Manager desktop-entry API
      settings = {
        StartupWMClass = wmClass;
      };
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
          description = "Display name (defaults to capitalized key)";
        };

        # icon name from homarr-labs/dashboard-icons/png (no .png)
        icon = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Icon name from homarr-labs/dashboard-icons";
        };

        categories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "Network" "WebBrowser" ];
        };

        extraFlags = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
        };
      };
    });

    default = {};
  };

  config = lib.mkIf (cfg != {}) {

    programs.brave.enable = true;

    # generate .desktop files
    xdg.desktopEntries =
      lib.mapAttrs mkWebApp cfg;

    # install icons from the fetched repo
    home.file =
      lib.mapAttrs'
        (slug: app:
          lib.optionalAttrs (app.icon != null) {
            name = ".local/share/icons/${slug}.png";
            value.source =
              "${dashboardIcons}/png/${app.icon}.png";
          }
        )
        cfg;
  };
}
