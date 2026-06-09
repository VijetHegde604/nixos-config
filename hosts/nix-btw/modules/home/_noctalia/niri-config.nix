{ ... }:

{
  programs.niri.settings = {
    # ┌──────────────────────────────┐
    # │ Startup & Environment        │
    # └──────────────────────────────┘
    spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
      {
        command = [
          "vicinae"
          "server"
        ];
      }
    ];

    environment = {
      XDG_CURRENT_DESKTOP = "niri";
    };

    # config-notification is not a valid Nix schema key — removed.
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    # ┌──────────────────────────────┐
    # │ Gestures & Input             │
    # └──────────────────────────────┘

    # FIX: hot-corners uses `enable = false`, not `off = true`
    gestures.hot-corners.enable = false;

    input = {
      keyboard.numlock = true;

      # FIX: focus-follows-mouse is a record, not a bare bool
      focus-follows-mouse.enable = true;

      touchpad = {
        tap = true;
        natural-scroll = true;
        accel-profile = "flat";
        dwt = true;
        scroll-factor = 0.2;
      };
    };

    debug.honor-xdg-activation-with-invalid-serial = true;

    # FIX: `off = true` → `enable = false`
    overview.workspace-shadow.enable = false;

    # ┌──────────────────────────────┐
    # │ Keybinds (Noctalia)          │
    # └──────────────────────────────┘
    binds = {
      "Mod+O" = {
        action.toggle-overview = [ ];
        repeat = false;
      };
      "Mod+Tab" = {
        action.toggle-overview = [ ];
        repeat = false;
      };
      "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

      "Mod+Return" = {
        action.spawn = "ghostty";
        hotkey-overlay.title = "Open Terminal";
      };
      "Mod+Space" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];
        hotkey-overlay.title = "Application Launcher";
      };
      "Mod+Shift+V" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "clipboard"
          "toggle"
        ];
        hotkey-overlay.title = "Clipboard Manager";
      };
      "Mod+M" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "systemMonitor"
          "toggle"
        ];
        hotkey-overlay.title = "Task Manager";
      };
      "Super+X" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "sessionMenu"
          "toggle"
        ];
        hotkey-overlay.title = "Power Menu: Toggle";
      };
      "Mod+Comma" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "settings"
          "toggle"
        ];
        hotkey-overlay.title = "Settings";
      };
      "Mod+Y" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "wallpaper"
          "toggle"
        ];
        hotkey-overlay.title = "Browse Wallpapers";
      };
      "Mod+N" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "controlCenter"
          "toggle"
        ];
        hotkey-overlay.title = "Notification Center";
      };
      "Mod+Shift+N" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "notepad"
          "toggle"
        ];
        hotkey-overlay.title = "Notepad";
      };

      "Mod+Alt+L" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "lockScreen"
          "lock"
        ];
        hotkey-overlay.title = "Lock Screen";
        allow-when-locked = true;
      };
      "Mod+Shift+E".action.quit = [ ];

      "XF86AudioRaiseVolume" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "increase"
        ];
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "decrease"
        ];
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "muteOutput"
        ];
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "muteInput"
        ];
        allow-when-locked = true;
      };
      "XF86AudioPlay" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "media"
          "playPause"
        ];
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "media"
          "next"
        ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessUp" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "brightness"
          "increase"
        ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "brightness"
          "decrease"
        ];
        allow-when-locked = true;
      };

      "Mod+W" = {
        action.close-window = [ ];
        repeat = false;
      };
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];
      "Mod+Shift+T".action.toggle-window-floating = [ ];

      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Right".action.focus-column-right = [ ];
      "Mod+Up".action.focus-window-up = [ ];
      "Mod+Down".action.focus-window-down = [ ];

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
    };
  };
}
