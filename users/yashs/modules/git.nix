{ ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "FC8FCCEB9A39DA92";
      signByDefault = true;
    };
    settings = {
      user.name = "Yash Sharma";
      user.email = "296458454+yashsio@users.noreply.github.com";
      diff.tool = "nvimdiff";
      difftool.prompt = false;
      difftool.nvimdiff.cmd = ''nvim -d "$LOCAL" "$REMOTE"'';
    };
  };
}


