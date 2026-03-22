{ pkgs, ... }:

{
  programs.bash.completion.enable = true;

  environment.shellAliases = {
    # navigation / ls replacements
    cd = "z";
    ls = "lsd";
    ll = "lsd -l";
    lt = "lsd --tree";
    cat = "bat";

    # tools
    lg = "lazygit";

    # nixos rebuild shortcuts
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#nix-server";
    nrb = "sudo nixos-rebuild boot --flake ~/nixos-config#nix-server";
    nrt = "sudo nixos-rebuild test --flake ~/nixos-config#nix-server";

    # update flake inputs then rebuild
    nfu = "nix flake update --flake ~/nixos-config && sudo nixos-rebuild switch --flake ~/nixos-config#nix-server";

    # nix store cleanup
    nixgc = "sudo nix-collect-garbage -d";
    nixopt = "sudo nix-store --optimise";

    # quick nix shell
    ns = "nix-shell -p";

    # docker helpers
    start-docker = "sudo systemctl start docker";
    stop-docker = "sudo systemctl stop docker && sudo systemctl stop docker.socket";
  };

  environment.shellInit = ''
    # If we are inside an SSH session, downgrade TERM
    if [ -n "$SSH_CONNECTION" ]; then
      export TERM=xterm-256color
    fi

    export TERM=xterm-256color

    # activate zoxide
    eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

    # source optional local bash snippets
    if [ -d ~/.bashrc.d ]; then
      for rc in ~/.bashrc.d/*; do
        [ -f "$rc" ] && . "$rc"
      done
    fi
  '';
}
