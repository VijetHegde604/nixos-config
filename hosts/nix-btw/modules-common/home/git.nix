{ pkgs, settings, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    settings = {
      user = {
        name = settings.gitUser;
        email = settings.gitEmail;
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
