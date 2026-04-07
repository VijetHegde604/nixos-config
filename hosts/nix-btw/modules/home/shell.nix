{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

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
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#nix-btw";
      nrb = "sudo nixos-rebuild boot --flake ~/nixos-config#nix-btw";
      nrt = "sudo nixos-rebuild test --flake ~/nixos-config#nix-btw";

      # update flake inputs then rebuild
      nfu = "nix flake update --flake ~/nixos-config && sudo nixos-rebuild switch --flake ~/nixos-config#nix-btw";

      # nix store cleanup helpers
      nixgc = "sudo nix-collect-garbage -d";
      nixopt = "sudo nix-store --optimise";

      # quick nix shell
      ns = "nix-shell -p";

      # docker helpers
      start-docker = "sudo systemctl start docker";
      stop-docker = "sudo systemctl stop docker && sudo systemctl stop docker.socket";

      # Editing the config
      edit-config = "zeditor ~/nixos-config"
    };

    initExtra = ''
      # Use a conservative TERM so remote/SSH environments behave consistently.
      export TERM=xterm-256color

      # activate mise and zoxide
      eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

      # source optional local bash snippets
      if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
          [ -f "$rc" ] && . "$rc"
        done
      fi

      export TERMINAL=ghostty
    '';
  };
}
