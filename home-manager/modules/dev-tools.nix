{ pkgs, ... }:

{
  programs = {
    go.enable = true;
    gpg.enable = true;

    jq = {
        enable = true;
        colors = {
            # Required fields
            null = "1;30";       # Dark gray
            false = "0;37";      # White
            true = "0;37";       # White
            numbers = "0;37";    # White
            strings = "0;32";    # Green
            arrays = "1;37";     # Bold white
            objects = "1;37";    # Bold white
            objectKeys = "0;34"; # Blue (this was missing)
        };
    };
  };
}