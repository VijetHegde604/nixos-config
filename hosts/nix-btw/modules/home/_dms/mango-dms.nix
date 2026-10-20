{ inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.mangowm.hmModules.mango
    inputs.vicinae.homeManagerModules.default
  ];

  wayland.windowManager.mango = {
    enable = true;
    systemd.enable = true;
    settings = {
      # Keep Mango visually close to the compact Niri setup.
      border_px = 2;
      gap_inner_horizontal = 8;
      gap_inner_vertical = 8;
      gap_outer_horizontal = 8;
      gap_outer_vertical = 8;
      border_radius = 8;
      animations = 1;

      bind = [
        # Applications and DMS shell controls
        "SUPER,Return,spawn,ghostty"
        "SUPER,space,spawn,vicinae toggle"
        "SUPER+SHIFT,V,spawn,dms ipc call clipboard toggle"
        "SUPER,M,spawn,dms ipc call processlist focusOrToggle"
        "SUPER,X,spawn,dms ipc call powermenu toggle"
        "SUPER,comma,spawn,dms ipc call settings focusOrToggle"
        "SUPER,Y,spawn,dms ipc call dankdash wallpaper"
        "SUPER,N,spawn,dms ipc call notifications toggle"
        "SUPER+SHIFT,N,spawn,dms ipc call notepad toggle"
        "SUPER+ALT,L,spawn,dms ipc call lock lock"
        "CTRL+ALT,Delete,spawn,dms ipc call processlist focusOrToggle"
        "SUPER+SHIFT,E,quit"

        # Overview and Mango-specific controls
        "SUPER,O,toggleoverview"
        "SUPER,TAB,toggleoverview"
        "SUPER,R,reload_config"
        "SUPER,grave,toggle_scratchpad"
        "SUPER+SHIFT,grave,minimized"
        "SUPER+CTRL,G,togglegaps"
        "SUPER+CTRL,B,toggle_render_border"
        "SUPER+CTRL,Return,zoom"

        # Window management and directional focus/movement
        "SUPER,Q,killclient"
        "SUPER,F,togglemaximizescreen"
        "SUPER+SHIFT,F,togglefullscreen"
        "SUPER+SHIFT,T,togglefloating"
        "SUPER+ALT,V,togglefloating"
        "SUPER,Left,focusdir,left"
        "SUPER,Down,focusdir,down"
        "SUPER,Up,focusdir,up"
        "SUPER,Right,focusdir,right"
        "SUPER,H,focusdir,left"
        "SUPER,J,focusdir,down"
        "SUPER,K,focusdir,up"
        "SUPER,L,focusdir,right"
        "SUPER+SHIFT,Left,exchange_client,left"
        "SUPER+SHIFT,Down,exchange_client,down"
        "SUPER+SHIFT,Up,exchange_client,up"
        "SUPER+SHIFT,Right,exchange_client,right"
        "SUPER+SHIFT,H,exchange_client,left"
        "SUPER+SHIFT,J,exchange_client,down"
        "SUPER+SHIFT,K,exchange_client,up"
        "SUPER+SHIFT,L,exchange_client,right"

        # Monitor focus and moving windows between monitors
        "SUPER+CTRL,Left,focusmon,left"
        "SUPER+CTRL,Right,focusmon,right"
        "SUPER+CTRL,H,focusmon,left"
        "SUPER+CTRL,L,focusmon,right"
        "SUPER+SHIFT+CTRL,Left,tagmon,left"
        "SUPER+SHIFT+CTRL,Right,tagmon,right"
        "SUPER+SHIFT+CTRL,H,tagmon,left"
        "SUPER+SHIFT+CTRL,L,tagmon,right"

        # Workspaces are Mango tags
        "SUPER,U,viewtoleft_have_client"
        "SUPER,I,viewtoright_have_client"
        "SUPER+SHIFT,U,tagtoleft"
        "SUPER+SHIFT,I,tagtoright"
        "SUPER,1,view,1"
        "SUPER,2,view,2"
        "SUPER,3,view,3"
        "SUPER,4,view,4"
        "SUPER,5,view,5"
        "SUPER,6,view,6"
        "SUPER,7,view,7"
        "SUPER,8,view,8"
        "SUPER,9,view,9"
        "SUPER+SHIFT,1,tag,1"
        "SUPER+SHIFT,2,tag,2"
        "SUPER+SHIFT,3,tag,3"
        "SUPER+SHIFT,4,tag,4"
        "SUPER+SHIFT,5,tag,5"
        "SUPER+SHIFT,6,tag,6"
        "SUPER+SHIFT,7,tag,7"
        "SUPER+SHIFT,8,tag,8"
        "SUPER+SHIFT,9,tag,9"
        "SUPER,Page_Down,viewtoright"
        "SUPER,Page_Up,viewtoleft"

        # Mango layouts and sizing
        "SUPER,F1,setlayout,scroller"
        "SUPER,F2,setlayout,tile"
        "SUPER,F3,setlayout,vertical_tile"
        "SUPER,minus,setmfact,-0.05"
        "SUPER,equal,setmfact,+0.05"
        "SUPER+SHIFT,minus,incgaps,-2"
        "SUPER+SHIFT,equal,incgaps,+2"

        # Media, brightness, and screenshots through DMS/utilities
        "NONE,XF86AudioRaiseVolume,spawn,dms ipc call audio increment 3"
        "NONE,XF86AudioLowerVolume,spawn,dms ipc call audio decrement 3"
        "NONE,XF86AudioMute,spawn,dms ipc call audio mute"
        "NONE,XF86AudioMicMute,spawn,dms ipc call audio micmute"
        "NONE,XF86AudioPlay,spawn,dms ipc call mpris playPause"
        "NONE,XF86AudioPrev,spawn,dms ipc call mpris previous"
        "NONE,XF86AudioNext,spawn,dms ipc call mpris next"
        "NONE,XF86MonBrightnessUp,spawn,dms ipc call brightness increment 5"
        "NONE,XF86MonBrightnessDown,spawn,dms ipc call brightness decrement 5"
        "SUPER,Print,spawn_shell,grim -g \"$(slurp)\" - | wl-copy"
        "SUPER+SHIFT,Print,spawn_shell,grim - | wl-copy"
      ];
    };
  };

  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    systemd.autoStart = true;
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };
}
