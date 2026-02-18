{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    settings = {
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      icon_theme = "Zed (Default)";
      ui_font_size = 16;
      buffer_font_size = 15;

      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Ayu Dark";
      };
    };
  };
}
