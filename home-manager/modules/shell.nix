{ pkgs, ... }:

{
  programs = {
    nix-index = {
        enable = true;
        enableZshIntegration = true;
        package = pkgs.nix-index;
    };

    nushell.enable = true;
    ripgrep.enable = true;
  };
}