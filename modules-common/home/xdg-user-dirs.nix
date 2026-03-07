{ ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      PROJECTS = "$HOME/Projects";
      WORK = "$HOME/Work";
      WALLPAPERS = "$HOME/Wallpapers";
      LEARNING = "$HOME/Learning";
    };
  };
}
