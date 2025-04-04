{ config, lib, pkgs, ... }:

let
  # New way to get elixir-ls (works with current nixpkgs)
  elixir-ls = pkgs.beamPackages.elixir-ls.override {
    elixir = pkgs.elixir;
  };
in
{
  options.elixir.enable = lib.mkEnableOption "Elixir development environment";

  config = lib.mkIf config.elixir.enable {
    home.packages = with pkgs; [
      elixir
      erlang
      rebar3
      erlang-ls
      elixir-ls
      mix2nix
    ];

    home.sessionVariables = {
      HEX_HOME = "${config.xdg.dataHome}/hex";
      MIX_HOME = "${config.xdg.dataHome}/mix";
      ERL_AFLAGS = "-kernel shell_history enabled";
    };
  };
}