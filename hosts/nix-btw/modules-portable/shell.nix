{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      # ───────── Navigation / ls replacements ─────────
      cd = "z";
      ls = "lsd";
      ll = "lsd -l";
      lt = "lsd --tree";
      cat = "bat";

      # ───────── Tools ─────────
      lg = "lazygit";

      # ───────── Nix / Home Manager (portable) ─────────
      hms = "home-manager switch --flake ~/nixos-config#vijeth-portable";

      nf = "nix flake update --flake ~/nixos-config";
      ns = "nix shell nixpkgs#"; # modern replacement for nix-shell -p

      # user-level nix cleanup (portable-safe)
      nixgc = "nix-collect-garbage -d";
      nixopt = "nix-store --optimise";

      # ───────── Docker helpers (portable) ─────────
      dps = "docker ps";
      dcu = "docker compose up";
      dcd = "docker compose down";
    };

    initExtra = ''
      # SSH-safe TERM
      if [ -n "$SSH_CONNECTION" ]; then
        export TERM=xterm-256color
      fi

      # zoxide
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

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];

  programs.zoxide.enable = true;
}
