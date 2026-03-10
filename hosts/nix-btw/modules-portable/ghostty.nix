{ ... }:

{
  xdg.configFile."ghostty/config".text = ''
    # ───────── Font ─────────
    font-size = 12

    # ───────── Window ─────────
    window-decoration = false
    window-padding-x = 12
    window-padding-y = 12
    background-opacity = 1.0
    background-blur-radius = 32

    # ───────── Cursor ─────────
    cursor-style = block
    cursor-style-blink = true

    # ───────── Scrollback ─────────
    scrollback-limit = 3023

    # ───────── Terminal behavior ─────────
    mouse-hide-while-typing = true
    copy-on-select = false
    confirm-close-surface = false

    app-notifications = no-clipboard-copy,no-config-reload

    # ───────── UI ─────────
    unfocused-split-opacity = 0.7
    gtk-titlebar = false
    gtk-single-instance = true

    # ───────── Shell integration ─────────
    shell-integration = detect
    shell-integration-features = cursor,sudo,title,no-cursor

    # ───────── Theme ─────────
    theme = dankcolors

    # ───────── Keybinds ─────────
    keybind = ctrl+shift+n=new_window
    keybind = ctrl+t=new_tab
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+zero=reset_font_size
    keybind = shift+enter=text:\n
  '';
}
