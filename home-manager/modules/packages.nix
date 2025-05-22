{ pkgs }:

with pkgs; [
    # RUST TUI/CLI Tools
    bottom
    du-dust
    fd
    procs
    ripgrep
    gitui
    tokei
    xan

    # Development
    helix
    jq
    git-crypt
    tig
    tree-sitter

    # RUST
    rustup

    # GO 
    go

    # Internet
    speedtest-cli

    # Media 
    imagemagick

    # Kubernetes
    kubectl 
    minikube
    kubectx

    # Overview
    wtfutil
    direnv

    zellij

    commitizen
]
