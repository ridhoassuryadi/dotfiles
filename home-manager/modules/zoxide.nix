{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;  # If you use zsh
    enableBashIntegration = true; # If you use bash
    enableFishIntegration = true; # If you use fish
    options = [
      "--cmd cd"  # This makes zoxide override the cd command
    ];
  };
}