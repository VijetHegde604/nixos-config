{config, pkgs, ...}:
{
xdg.userDirs = {
  enable = true;
  createDirectories = true;
  # documents = "Documents";
  # download = "Downloads";
  # pictures = "Pictures";
  extraConfig = {
    PROJECTS = "$HOME/Projects";
    WORK = "$HOME/Work";
    WALLPAPERS = "$HOME/Wallpapers";
  };
};
}
