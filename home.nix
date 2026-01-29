{ config, pkgs, ... }:

{
  home.username = "vijeth";
  home.homeDirectory = "/home/vijeth";
  home.stateVersion = "25.11";

  # --- Starship Prompt ---
  programs.starship = {
    enable = true;
    # We use 'lib.importTOML' if you keep it in a separate file, 
    # but here is the inline version of your custom config:
    settings = {
      add_newline = true;
      palette = "material_vijet";
      format = "[\\$username@\\$hostname ](fg:muted)[\\$directory](fg:dir) \\$python\\$nodejs\\$rust\\$golang\\$package\\$git_branch\\$git_status\\$cmd_duration\n\\$character";
      right_format = "\\$time\\$battery";

      palettes.material_vijet = {
        muted = "#78828c";
        accent = "#b5d0ff";
        accent_dim = "#8caac8";
        danger = "#ff6b6b";
        good = "#9ccc65";
        dir = "#8caac8";
        subtle = "#9aa5b1";
      };

      username = { show_always = true; format = "[$user]($style)"; style_user = "fg:muted"; };
      hostname = { ssh_only = false; format = "[$hostname]($style)"; style = "fg:muted"; };
      directory = { 
        truncation_length = 3; 
        style = "fg:dir"; 
        read_only = " "; 
        format = "[$path]($style)[$read_only]($style)";
      };
      
      git_branch = { symbol = " "; format = " [$symbol$branch]($style)"; style = "fg:accent"; };
      git_status = {
        format = "[( $all_status$ahead_behind)]($style)";
        style = "fg:accent";
        ahead = "↑\${count}";
        behind = "↓\${count}";
        diverged = "↑\${ahead_count}↓\${behind_count}";
      };

      python = { symbol = " "; format = " [$symbol$virtualenv]($style)"; style = "fg:accent_dim"; };
      battery.display = [
        { threshold = 20; style = "fg:danger"; }
        { threshold = 100; style = "fg:subtle"; }
      ];
      # Note: Add other language modules here as needed based on your TOML
    };
  };

  # --- Bash Configuration ---
  programs.bash = {
    enable = true;
    enableCompletion = true;
    sessionVariables = {
      TERM = "xterm-256color";
    };
    shellAliases = {
      cd = "z";
      ls = "lsd";
      ll = "lsd -l";
      lt = "lsd --tree";
      start-docker = "sudo systemctl start docker";
      stop-docker = "sudo systemctl stop docker && sudo systemctl stop docker.socket";
    };
    initExtra = ''
      # Evaluate mise and zoxide (Nix-managed paths)
      eval "$(${pkgs.mise}/bin/mise activate bash)"
      eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

      # Source local overrides if they exist
      if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
          [ -f "$rc" ] && . "$rc"
        done
      fi
    '';
  };

  # --- Git Configuration ---
  programs.git = {
    enable = true;
    userName = "VijetHegde604";
    userEmail = "vijethegde604@gmail.com";
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      diff = { algorithm = "histogram"; colorMoved = "plain"; mnemonicPrefix = true; };
      commit.verbose = true;
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "-version:refname";
      rerere = { enabled = true; autoupdate = true; };
      credential.helper = "libsecret";
    };
  };

  programs.home-manager.enable = true;
}