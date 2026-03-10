{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    config = {
      user = {
        name = "VijetHegde604";
        email = "vijethegde604@gmail.com";
      };

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
      };

      init.defaultBranch = "main";

      pull.rebase = true;
      push.autoSetupRemote = true;

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
      };

      commit.verbose = true;

      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "-version:refname";

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      credential.helper = "libsecret";
    };
  };
}
