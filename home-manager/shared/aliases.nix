{ pkgs }: {
  git = {
    st = "status";
    co = "checkout";
    cm = "commit -m";
  };

  gh = {
    pr-view = "pr view --web";
    issue-create = "issue create --web";
  };
}