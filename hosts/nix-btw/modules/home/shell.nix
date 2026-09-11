{ pkgs, settings, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Sensible history defaults
    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      extended = true;       # Timestamps in history
      share = true;          # Share history across sessions
    };

    shellAliases = {
      # navigation / ls replacements
      cd = "z";
      ls = "lsd";
      ll = "lsd -l";
      lt = "lsd --tree";
      cat = "bat";

      # tools
      lg = "lazygit";

      # nixos rebuild shortcuts (flake-based)
      nrs = "sudo nixos-rebuild switch --flake ${settings.configRepoPath}#nix-btw";
      nrb = "sudo nixos-rebuild boot --flake ${settings.configRepoPath}#nix-btw";
      nrt = "sudo nixos-rebuild test --flake ${settings.configRepoPath}#nix-btw";

      # update flake inputs then rebuild
      nfu = "nix flake update --flake ${settings.configRepoPath} && sudo nixos-rebuild switch --flake ${settings.configRepoPath}#nix-btw";

      # nix store cleanup helpers
      nixgc = "sudo nix-collect-garbage -d";
      nixopt = "sudo nix-store --optimise";

      # quick nix shell
      ns = "nix-shell -p";

      # docker helpers
      start-docker = "sudo systemctl start docker";
      stop-docker = "sudo systemctl stop docker && sudo systemctl stop docker.socket";

      # Editing the config
      edit-config = "zeditor ${settings.configRepoPath}";
    };

    initContent = ''
      # Use a conservative TERM so remote/SSH environments behave consistently.
      export TERM=xterm-256color

      # activate zoxide
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

      # source optional local zsh snippets
      if [ -d ~/.zshrc.d ]; then
        for rc in ~/.zshrc.d/*; do
          [ -f "$rc" ] && . "$rc"
        done
      fi

      export TERMINAL=ghostty

      # Better directory navigation
      setopt AUTO_CD              # cd by just typing dir name
      setopt AUTO_PUSHD           # push dirs onto stack automatically
      setopt PUSHD_IGNORE_DUPS    # no duplicates in dir stack
      setopt PUSHD_SILENT         # don't print stack after pushd/popd

      # Case-insensitive and partial completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    '';
  };
}
