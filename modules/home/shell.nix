{ config, pkgs, ... }:

{
  home.sessionVariables = {
    TERM = "xterm-256color";
  };

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
      lg = "lazygit";
      start-docker = "sudo systemctl start docker";
      stop-docker  = "sudo systemctl stop docker && sudo systemctl stop docker.socket";
      
    };

    initExtra = ''
      eval "$(${pkgs.mise}/bin/mise activate bash)"
      eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

      if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
          [ -f "$rc" ] && . "$rc"
        done
      fi
    '';
  };

  programs.zoxide.enable = true;
}
