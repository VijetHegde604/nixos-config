{ ... }:

{
  programs.zed-editor = {
    enable = true;
    # Automatically install extensions via Nix
    extensions = [
      "nix"
      "rust"
      "toml"
      "go"
      "python"
      "yaml"
      "json"
      "git-firefly"
      "rumdl"
    ];

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      autosave = {
        after_delay = {
          milliseconds = 500;
        };
      };
      theme = {
        mode = "dark";
        dark = "Ayu Dark";
        light = "Ayu Light";
      };

      ui_font_size = 16;
      buffer_font_size = 15;
      buffer_font_family = "JetBrains Mono"; # Highly recommended for coding

      terminal = {
        font_family = "JetBrains Mono";
        copy_on_select = true;
      };

      languages = {
        Go = {
          format_on_save = "on";
          formatter = "auto";
        };
        Python = {
          format_on_save = "on";
          formatter = "auto";
        };
        JavaScript = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "auto";
              arguments = [
                "--stdin-filepath"
                "{buffer_path}"
              ];
            };
          };
        };
      };

      lsp = {
        gopls = {
          settings = {
            hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              parameterNames = true;
            };
          };
        };
      };
    };
  };
}
