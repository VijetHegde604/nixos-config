{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      palette = "material_vijet";

      format = ''
[$username@$hostname ](fg:muted)[$directory](fg:dir) $python$nodejs$rust$golang$package$git_branch$git_status$cmd_duration
$character
'';

      right_format = "$time$battery";

      palettes.material_vijet = {
        muted = "#78828c";
        accent = "#b5d0ff";
        accent_dim = "#8caac8";
        danger = "#ff6b6b";
        good = "#9ccc65";
        dir = "#8caac8";
        subtle = "#9aa5b1";
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "fg:muted";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style)";
        style = "fg:muted";
      };

      directory = {
        truncation_length = 3;
        style = "fg:dir";
        read_only = " ";
        format = "[$path]($style)[$read_only]($style)";
      };

      git_branch = {
        symbol = " ";
        format = " [$symbol$branch]($style)";
        style = "fg:accent";
      };

      git_status = {
        format = "[( $all_status$ahead_behind)]($style)";
        style = "fg:accent";
        ahead = "↑ $count";
        behind = "↓ $count";
        diverged = "↑ $ahead_count↓$behind_count";
      };

      cmd_duration = {
        min_time = 500;
        format = " [⏱ $duration]($style)";
        style = "fg:accent_dim";
      };

      python  = { symbol = " "; format = " [$symbol$virtualenv]($style)"; style = "fg:accent_dim"; };
      nodejs  = { symbol = " "; format = " [$symbol]($style)";           style = "fg:accent_dim"; };
      rust    = { symbol = " "; format = " [$symbol]($style)";           style = "fg:accent_dim"; };
      golang  = { symbol = " "; format = " [$symbol]($style)";           style = "fg:accent_dim"; };

      battery.display = [
        { threshold = 20;  style = "fg:danger"; }
        { threshold = 100; style = "fg:subtle"; }
      ];

      time = {
        disabled = false;
        format = "[$time]($style) ";
        style = "fg:subtle";
      };
    };
  };
}
