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

    config-notification.disable-failed = true;
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    # ┌──────────────────────────────┐
    # │ Gestures & Input             │
    # └──────────────────────────────┘
    gestures.hot-corners.off = true;

    input = {
      keyboard.numlock = true;
      focus-follows-mouse = true;
      touchpad = {
        tap = true;
        natural-scroll = true;
        accel-profile = "flat";
        dwt = true;
        scroll-factor = 0.2;
      };
    };

    # ┌──────────────────────────────┐
    # │ Appearance & Layout          │
    # └──────────────────────────────┘
    layout = {
      background-color = "transparent";
      center-focused-column = "never";
      default-column-width = {
        proportion = 0.5;
      };

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      border = {
        off = true;
        width = 4;
        active-color = "#707070";
        inactive-color = "#d0d0d0";
        urgent-color = "#cc4444";
      };

      shadow = {
        softness = 30;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
        color = "#0007";
      };
    };

    animations = {
      workspace-switch.spring = {
        damping-ratio = 0.80;
        stiffness = 523;
        epsilon = 0.0001;
      };
      window-open = {
        duration-ms = 150;
        curve = "ease-out-expo";
      };
      window-close = {
        duration-ms = 150;
        curve = "ease-out-quad";
      };
      horizontal-view-movement.spring = {
        damping-ratio = 0.85;
        stiffness = 423;
        epsilon = 0.0001;
      };
      window-movement.spring = {
        damping-ratio = 0.75;
        stiffness = 323;
        epsilon = 0.0001;
      };
      window-resize.spring = {
        damping-ratio = 0.85;
        stiffness = 423;
        epsilon = 0.0001;
      };
      config-notification-open-close.spring = {
        damping-ratio = 0.65;
        stiffness = 923;
        epsilon = 0.001;
      };
      screenshot-ui-open = {
        duration-ms = 200;
        curve = "ease-out-quad";
      };
      overview-open-close.spring = {
        damping-ratio = 0.85;
        stiffness = 800;
        epsilon = 0.0001;
      };
    };

    # ┌──────────────────────────────┐
    # │ Window & Layer Rules         │
    # └──────────────────────────────┘
    window-rules = [
      {
        match.app-id = "^org\\.wezfurlong\\.wezterm$";
        default-column-width = { };
      }
      {
        match.app-id = "^org\\.gnome\\.";
        draw-border-with-background = false;
        geometry-corner-radius = 12.0;
        clip-to-geometry = true;
      }
      {
        match = [
          { app-id = "^gnome-control-center$"; }
          { app-id = "^pavucontrol$"; }
          { app-id = "^nm-connection-editor$"; }
        ];
        default-column-width = {
          proportion = 0.5;
        };
        open-floating = false;
      }
      {
        match = [
          { app-id = "^gnome-calculator$"; }
          { app-id = "^galculator$"; }
          { app-id = "^blueman-manager$"; }
          { app-id = "^org\\.gnome\\.Nautilus$"; }
          { app-id = "^steam$"; }
          { app-id = "^xdg-desktop-portal$"; }
        ];
        open-floating = true;
      }
      {
        match = [
          { app-id = "^org\\.wezfurlong\\.wezterm$"; }
          { app-id = "Alacritty"; }
          { app-id = "zen"; }
          { app-id = "com.mitchellh.ghostty"; }
          { app-id = "kitty"; }
        ];
        draw-border-with-background = false;
      }
      {
        match = {
          app-id = "firefox$";
          title = "^Picture-in-Picture$";
        };
        open-floating = true;
      }
      {
        match.app-id = "org.quickshell$";
        open-floating = true;
      }
    ];

    layer-rules = [
      {
        match.namespace = "^quickshell$";
        place-within-backdrop = true;
      }
    ];

    # ┌──────────────────────────────┐
    # │ Debug & Overviews            │
    # └──────────────────────────────┘
    debug.honor-xdg-activation-with-invalid-serial = true;
    overview.workspace-shadow.off = true;

    recent-windows = {
      binds = {
        "Alt+Tab" = {
          next-window.scope = "output";
        };
        "Alt+Shift+Tab" = {
          previous-window.scope = "output";
        };
        "Alt+grave" = {
          next-window.filter = "app-id";
        };
        "Alt+Shift+grave" = {
          previous-window.filter = "app-id";
        };
      };
    };

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
