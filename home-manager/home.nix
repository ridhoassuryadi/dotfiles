{ config, pkgs, ... }:

let
  username = "ridho"; # Replace with your username
in
{
  imports = [
    ./modules/cli-tools.nix
    ./modules/dev-tools.nix
    ./modules/neovim.nix
    ./modules/elixir.nix
    ./modules/postgres.nix
    ./modules/nodejs.nix
    ./modules/shell.nix
  ];

  elixir.enable = true;
  postgres.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ridho";
  home.homeDirectory = "/Users/ridho";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  nixpkgs.overlays = [ (import ./overlays/neovim.nix) ];

  # Import aliases
  home.shellAliases = (import ./shared/aliases.nix { inherit pkgs; }).shell;
  
  # Import environment variables
  home.sessionVariables = (import ./shared/env.nix { inherit pkgs username; });

  # Import Packages
  home.packages = import ./modules/packages.nix { inherit pkgs; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
