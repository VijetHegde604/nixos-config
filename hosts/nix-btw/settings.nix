{
  # User and Machine Identity
  username = "vijeth";
  hostname = "nix-btw";
  configRepoPath = "/home/vijeth/nixos-config";

  # Localization Settings
  timezone = "Asia/Kolkata";
  locale = "en_US.UTF-8";

  # Boot and Styling
  secureBoot = false; # Set to false to disable during installation
  plymouthTheme = "connect";

  # Git Configuration
  gitUser = "VijetHegde604";
  gitEmail = "vijethegde604@gmail.com";

  virtualization = false;

  gaming = false;

  # Select one of: dms, noctalia, plasma.
  # Plasma is configured declaratively through plasma-manager.
  desktopShell = "dms";

  systemVersion = "26.05";
}
