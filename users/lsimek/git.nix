{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "tinjano@proton.me";
        name = "lsimek";
      };
      receive.denyCurrentBranch = "warn";
      pull.rebase = true;
      core.editor = "hx";
    };
  };

}
