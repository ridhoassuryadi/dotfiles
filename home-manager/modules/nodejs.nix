{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yarn
    nodePackages.npm
    nodePackages.typescript
    nodePackages.prettier
  ];
}