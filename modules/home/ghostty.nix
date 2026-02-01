{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      # ───────── Font ─────────
      font-size = 12;

      # ───────── Window ─────────
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      background-opacity = 1.0;
      background-blur-radius = 32;

      # ───────── Cursor ─────────
      cursor-style = "block";
      cursor-style-blink = true;

      # ───────── Scrollback ─────────
      scrollback-limit = 3023;

      # ───────── Terminal behavior ─────────
      mouse-hide-while-typing = true;
      copy-on-select = false;
      confirm-close-surface = false;

      # Disable annoying notifications
      app-notifications = "no-clipboard-copy,no-config-reload";

      # ───────── Material You UI ─────────
      unfocused-split-opacity = 0.7;
      unfocused-split-fill = "#44464f";

      # ───────── Tabs ─────────
      gtk-titlebar = false;

      # ───────── Shell integration ─────────
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title,no-cursor";

      # ───────── Misc ─────────
      gtk-single-instance = true;

      # ───────── Theme ─────────
      theme = "dankcolors";
    };

    keybindings = {
      "ctrl+shift+n" = "new_window";
      "ctrl+t" = "new_tab";
      "ctrl+plus" = "increase_font_size:1";
      "ctrl+minus" = "decrease_font_size:1";
      "ctrl+zero" = "reset_font_size";
      "shift+enter" = "text:\n";
    };
  };
}
