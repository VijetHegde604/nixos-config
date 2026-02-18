{ ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
    ];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "Ayu Dark";
        light = "Ayu Light";
      };
      autosave = {
        after_delay = {
          milliseconds = 500;
        };
      };
    };
  };
}
