{ pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri-flake.homeModules.niri
  ];

  home.packages = with pkgs; [
    cliphist
    grim
    pavucontrol
    slurp
    wl-clipboard
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.noctalia = {
    enable = true;

    # Inspired by crayonnova/dotfiles' Noctalia setup: a floating top bar,
    # compact bottom dock, Tokyo Night colors, searchable launcher, and
    # command-backed clipboard history. Keep this isolated from DMS config.
    settings = {
      appLauncher = {
        autoPasteClipboard = false;
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWrapText = true;
        enableClipPreview = true;
        enableClipboardChips = true;
        enableClipboardHistory = true;
        enableClipboardSmartIcons = true;
        enableSessionSearch = true;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        iconMode = "tabler";
        position = "center";
        screenshotAnnotationTool = "";
        showCategories = true;
        showIconBackground = false;
        sortByMostUsed = true;
        terminalCommand = "ghostty -e";
        viewMode = "list";
      };

      audio = {
        preferredPlayer = "";
        spectrumFrameRate = 30;
        spectrumMirrored = true;
        visualizerType = "linear";
        volumeFeedback = false;
        volumeOverdrive = false;
        volumeStep = 5;
      };

      bar = {
        autoHideDelay = 500;
        autoShowDelay = 150;
        backgroundOpacity = 0.93;
        barType = "floating";
        capsuleColorKey = "none";
        capsuleOpacity = 1;
        contentPadding = 2;
        density = "comfortable";
        displayMode = "always_visible";
        enableExclusionZoneInset = true;
        fontScale = 1;
        frameRadius = 12;
        frameThickness = 8;
        hideOnOverview = false;
        marginHorizontal = 4;
        marginVertical = 4;
        outerCorners = true;
        position = "top";
        rightClickAction = "controlCenter";
        rightClickFollowMouse = true;
        showCapsule = true;
        showOnWorkspaceSwitch = true;
        showOutline = false;
        widgetSpacing = 6;

        widgets = {
          left = [
            {
              id = "Workspace";
              characterCount = 2;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              fontWeight = "bold";
              hideUnoccupied = false;
              iconScale = 0.8;
              labelMode = "index";
              occupiedColor = "secondary";
              pillSize = 0.6;
              showApplications = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
            }
            {
              id = "ActiveWindow";
              hideMode = "hidden";
              maxWidth = 700;
              scrollingMode = "hover";
              showIcon = true;
              showText = true;
              textColor = "none";
              useFixedWidth = false;
            }
          ];

          center = [
            {
              id = "Clock";
              clockColor = "none";
              customFont = "Sans Serif";
              formatHorizontal = "h:mm AP ddd, MMM dd yyyy";
              formatVertical = "HH mm - dd MM";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
            }
          ];

          right = [
            {
              id = "MediaMini";
              compactMode = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              maxWidth = 145;
              panelShowAlbumArt = false;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              textColor = "none";
              visualizerType = "linear";
            }
            {
              id = "Tray";
              chevronColor = "none";
              colorizeIcons = false;
              drawerEnabled = false;
              hidePassive = false;
            }
            {
              id = "SystemMonitor";
              compactMode = true;
              diskPath = "/";
              iconColor = "none";
              showCpuTemp = true;
              showCpuUsage = true;
              showMemoryUsage = true;
              textColor = "none";
              useMonospaceFont = true;
              usePadding = false;
            }
            {
              id = "NotificationHistory";
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              iconColor = "none";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
            {
              id = "Volume";
              displayMode = "onhover";
              iconColor = "none";
              middleClickCommand = "pavucontrol";
              textColor = "none";
            }
            {
              id = "Brightness";
              applyToAllMonitors = false;
              displayMode = "onhover";
              iconColor = "none";
              textColor = "none";
            }
            {
              id = "Battery";
              deviceNativePath = "__default__";
              displayMode = "graphic-clean";
              hideIfIdle = false;
              hideIfNotDetected = true;
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
            }
          ];
        };
      };

      brightness = {
        brightnessStep = 5;
        enableDdcSupport = false;
        enforceMinimum = true;
      };

      calendar.cards = [
        { id = "calendar-header-card"; enabled = true; }
        { id = "calendar-month-card"; enabled = true; }
        { id = "weather-card"; enabled = true; }
      ];

      colorSchemes = {
        darkMode = true;
        generationMethod = "muted";
        predefinedScheme = "Tokyo Night";
        schedulingMode = "off";
        syncGsettings = true;
        useWallpaperColors = false;
      };

      controlCenter = {
        position = "top_left";
        diskPath = "/";
        cards = [
          { id = "profile-card"; enabled = true; }
          { id = "shortcuts-card"; enabled = true; }
          { id = "audio-card"; enabled = true; }
          { id = "brightness-card"; enabled = false; }
          { id = "weather-card"; enabled = true; }
          { id = "media-sysmon-card"; enabled = true; }
        ];
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "WallpaperSelector"; }
            { id = "NoctaliaPerformance"; }
          ];
          right = [
            { id = "Notifications"; }
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };
      };

      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        gridSnapScale = false;
        overviewEnabled = true;
      };

      dock = {
        animationSpeed = 1;
        backgroundOpacity = 1;
        colorizeIcons = true;
        deadOpacity = 0.6;
        displayMode = "always_visible";
        dockType = "attached";
        enabled = true;
        floatingRatio = 1;
        groupApps = false;
        groupClickAction = "cycle";
        groupContextMenuMode = "extended";
        groupIndicatorStyle = "dots";
        inactiveIndicators = false;
        indicatorColor = "primary";
        indicatorOpacity = 0.6;
        indicatorThickness = 6;
        launcherPosition = "end";
        launcherUseDistroLogo = false;
        onlySameOutput = true;
        pinnedApps = [ ];
        pinnedStatic = false;
        position = "bottom";
        showDockIndicator = true;
        showLauncherIcon = true;
        sitOnFrame = false;
        size = 1.18;
      };

      general = {
        allowPanelsOnScreenWithoutBar = true;
        animationDisabled = false;
        animationSpeed = 1;
        boxRadiusRatio = 1;
        clockFormat = "hh\\nmm";
        clockStyle = "custom";
        compactLockScreen = false;
        dimmerOpacity = 0;
        enableBlurBehind = true;
        enableLockScreenCountdown = true;
        enableLockScreenMediaControls = false;
        enableShadows = false;
        forceBlackScreenCorners = false;
        iRadiusRatio = 1;
        lockOnSuspend = true;
        lockScreenAnimations = false;
        lockScreenBlur = 0;
        lockScreenCountdownDuration = 10000;
        lockScreenTint = 0;
        passwordChars = false;
        radiusRatio = 0.87;
        reverseScroll = false;
        scaleRatio = 1;
        screenRadiusRatio = 0;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showChangelogOnStartup = true;
        showHibernateOnLockScreen = false;
        showScreenCorners = true;
        showSessionButtonsOnLockScreen = true;
        smoothScrollEnabled = true;
        telemetryEnabled = false;
      };

      idle = {
        enabled = false;
        fadeDuration = 5;
        lockTimeout = 660;
        screenOffTimeout = 600;
        suspendTimeout = 1800;
      };

      location = {
        analogClockInCalendar = false;
        autoLocate = false;
        firstDayOfWeek = -1;
        hideWeatherCityName = false;
        hideWeatherTimezone = false;
        name = "Bengaluru";
        showCalendarEvents = true;
        showCalendarWeather = true;
        use12hourFormat = true;
        useFahrenheit = false;
        weatherEnabled = true;
        weatherShowEffects = true;
      };

      network = {
        bluetoothAutoConnect = true;
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        networkPanelView = "wifi";
        wifiDetailsViewMode = "grid";
      };

      nightLight = {
        autoSchedule = true;
        dayTemp = "6500";
        enabled = false;
        forced = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "4000";
      };

      notifications = {
        backgroundOpacity = 1;
        clearDismissed = true;
        criticalUrgencyDuration = 15;
        density = "default";
        enableBatteryToast = true;
        enableKeyboardLayoutToast = true;
        enableMarkdown = false;
        enableMediaToast = false;
        enabled = true;
        location = "top_right";
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        overlayLayer = true;
        respectExpireTimeout = false;
        sounds.enabled = false;
      };

      osd = {
        autoHideMs = 2000;
        backgroundOpacity = 1;
        enabled = true;
        enabledTypes = [ 0 1 2 ];
        location = "top_right";
        overlayLayer = true;
      };

      sessionMenu = {
        countdownDuration = 5000;
        enableCountdown = true;
        largeButtonsLayout = "single-row";
        largeButtonsStyle = true;
        position = "center";
        showHeader = true;
        showKeybinds = true;
      };

      systemMonitor = {
        batteryCriticalThreshold = 5;
        batteryWarningThreshold = 20;
        cpuCriticalThreshold = 90;
        cpuWarningThreshold = 80;
        diskPath = "/";
        memCriticalThreshold = 90;
        memWarningThreshold = 80;
        tempCriticalThreshold = 90;
        tempWarningThreshold = 80;
        useCustomColors = false;
      };

      ui = {
        boxBorderEnabled = true;
        fontDefault = "Sans Serif";
        fontDefaultScale = 1.1;
        fontFixed = "monospace";
        fontFixedScale = 1;
        panelBackgroundOpacity = 0.93;
        panelsAttachedToBar = true;
        scrollbarAlwaysVisible = true;
        settingsPanelMode = "centered";
        settingsPanelSideBarCardStyle = false;
        tooltipsEnabled = true;
        translucentWidgets = true;
      };

      wallpaper = {
        automationEnabled = false;
        directory = "~/Pictures/Wallpapers";
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        linkLightAndDarkWallpapers = true;
        overviewBlur = 0.4;
        overviewEnabled = false;
        overviewTint = 0.6;
        panelPosition = "center";
        randomIntervalSec = 300;
        setWallpaperOnAllMonitors = true;
        showHiddenFiles = false;
        skipStartupTransition = false;
        solidColor = "#1a1a2e";
        sortOrder = "name";
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = [ "fade" "disc" "stripes" "wipe" "pixelate" "honeycomb" ];
        useOriginalImages = false;
        useSolidColor = false;
        useWallhaven = true;
        viewMode = "recursive";
        wallhavenCategories = "111";
        wallhavenOrder = "desc";
        wallhavenPurity = "100";
        wallhavenQuery = "wall";
        wallhavenResolutionMode = "atleast";
        wallhavenSorting = "relevance";
        wallpaperChangeMode = "random";
      };
    };
  };
}
