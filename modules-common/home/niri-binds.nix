{ ... }:

{
  programs.niri.settings.binds = {
    # === System & Overview ===
    "Mod+O" = {
      action.toggle-overview = [ ];
      repeat = false;
    };
    "Mod+Tab" = {
      action.toggle-overview = [ ];
      repeat = false;
    };
    "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

    # === Application Launchers ===
    "Mod+Return" = {
      action.spawn = "ghostty";
      hotkey-overlay.title = "Open Terminal";
    };
    "Mod+Space" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "spotlight"
        "toggle"
      ];
      hotkey-overlay.title = "Application Launcher";
    };
    "Mod+Shift+V" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "clipboard"
        "toggle"
      ];
      hotkey-overlay.title = "Clipboard Manager";
    };
    "Mod+M" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "processlist"
        "focusOrToggle"
      ];
      hotkey-overlay.title = "Task Manager";
    };
    "Super+X" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "powermenu"
        "toggle"
      ];
      hotkey-overlay.title = "Power Menu: Toggle";
    };
    "Mod+Comma" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "settings"
        "focusOrToggle"
      ];
      hotkey-overlay.title = "Settings";
    };
    "Mod+Y" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "dankdash"
        "wallpaper"
      ];
      hotkey-overlay.title = "Browse Wallpapers";
    };
    "Mod+N" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "notifications"
        "toggle"
      ];
      hotkey-overlay.title = "Notification Center";
    };
    "Mod+Shift+N" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "notepad"
        "toggle"
      ];
      hotkey-overlay.title = "Notepad";
    };

    # === Security ===
    "Mod+Alt+L" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "lock"
        "lock"
      ];
      hotkey-overlay.title = "Lock Screen";
      allow-when-locked = true;
    };
    "Mod+Shift+E".action.quit = [ ];
    "Ctrl+Alt+Delete" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "processlist"
        "focusOrToggle"
      ];
      hotkey-overlay.title = "Task Manager";
    };

    # === Audio Controls ===
    "XF86AudioRaiseVolume" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "increment"
        "3"
      ];
      allow-when-locked = true;
    };
    "XF86AudioLowerVolume" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "decrement"
        "3"
      ];
      allow-when-locked = true;
    };
    "XF86AudioMute" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "mute"
      ];
      allow-when-locked = true;
    };
    "XF86AudioMicMute" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "micmute"
      ];
      allow-when-locked = true;
    };
    "XF86AudioPause" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "playPause"
      ];
      allow-when-locked = true;
    };
    "XF86AudioPlay" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "playPause"
      ];
      allow-when-locked = true;
    };
    "XF86AudioPrev" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "previous"
      ];
      allow-when-locked = true;
    };
    "XF86AudioNext" = {
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "next"
      ];
      allow-when-locked = true;
    };

    # === Window Management ===
    "Mod+W" = {
      action.close-window = [ ];
      repeat = false;
    };
    "Mod+F".action.maximize-column = [ ];
    "Mod+Shift+F".action.fullscreen-window = [ ];
    "Mod+Shift+T".action.toggle-window-floating = [ ];
    "Mod+Alt+V".action.switch-focus-between-floating-and-tiling = [ ];
    "Mod+Shift+W".action.toggle-column-tabbed-display = [ ];

    # === Navigation ===
    "Mod+Left".action.focus-column-left = [ ];
    "Mod+Down".action.focus-window-down = [ ];
    "Mod+Up".action.focus-window-up = [ ];
    "Mod+Right".action.focus-column-right = [ ];
    "Mod+H".action.focus-column-left = [ ];
    "Mod+J".action.focus-window-down = [ ];
    "Mod+K".action.focus-window-up = [ ];
    "Mod+L".action.focus-column-right = [ ];

    # === Workspaces ===
    "Mod+Page_Down".action.focus-workspace-down = [ ];
    "Mod+Page_Up".action.focus-workspace-up = [ ];
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;

    # === Mouse Wheel ===
    "Mod+WheelScrollDown" = {
      action.focus-workspace-down = [ ];
      cooldown-ms = 150;
    };
    "Mod+WheelScrollUp" = {
      action.focus-workspace-up = [ ];
      cooldown-ms = 150;
    };

    # === System Controls ===
    "Mod+Escape" = {
      action.toggle-keyboard-shortcuts-inhibit = [ ];
      allow-inhibiting = false;
    };
    "Mod+Shift+P".action.power-off-monitors = [ ];

    # Emulate Copy/Paste with wtype
    "Mod+C".action.spawn = [
      "sh"
      "-c"
      "wtype -M ctrl -k Insert -m ctrl"
    ];
    "Mod+V".action.spawn = [
      "sh"
      "-c"
      "wtype -M shift -k Insert -m shift"
    ];
  };
}
