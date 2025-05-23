{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    
    # Corrected oh-my-zsh configuration (with hyphens)
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "ssh-agent" ];
    };

    shellAliases = {
      # Overirde Default alias
      ls = "eza";
      lt = "eza --tree";
      lta = "eza --tree -a";
      ltd = "eza --tree -d";

      # Kubernetes
      k = "kubectl";
      ka = "kubectl get all -o wide";
      ks = "kubectl get services -o wide";
      kap = "kubectl apply -f";

      # Config editing
      ez = "nvim ~/.zshrc";
      ev = "nvim ~/.config/nvim/init.vim";
      rlz = "source ~/.zshrc";

      # Directory navigation
      rz = "cd ~/raizora";
      rzwd = "cd ~/raizora/wadah-depan-web";
      rzpk = "cd ~/raizora/perkakas";
      rzwb = "cd ~/raizora/wadah-belakang-web";
      rc = "cd ~/redant";
      rcwm = "cd ~/redant/web-monorepo";

      # Frontend commands
      ya = "yarn add";
      ni = "npm i";
      ns = "npm start";
      nd = "npm run dev";
      nb = "npm run build";
      pb = "pnpm run build";
      v = "nvim";

      # NIX
      hmb = "home-manager build";
      hms = "home-manager switch";
    };

    initContent = ''
      # PATH configurations
      export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
      export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

      # Go configurations
      export GOROOT="${pkgs.go}/share/go"
      export GOPATH="$HOME/Documents/go"
      export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
      export GITHUBPATH="$GOPATH/github.com"
      export RZPATH="$GITHUBPATH/raizora"
      export PSPATH="$GITHUBPATH/ridhoassuryadi"
      export RACPATH="$GITHUBPATH/red-ant-colony"

      # Code Editor
      export PATH="$PATH:$HOME/.codeium/windsurf/bin"

      # Android
      export ANDROID_HOME="$HOME/Library/Android/sdk"
      export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/emulator"

      # Docker completions
      fpath=($HOME/.docker/completions $fpath)
      autoload -Uz compinit
      compinit

      # SARU CLI
      export SARU_SOURCE="$HOME/Documents/go/github.com/red-ant-colony/backend-monorepo/apps/saru-cli"
      export SARU_PLAYGROUND="$HOME/Documents/go/github.com/red-ant-colony"

      export SARU_PATH="$HOME/.saru/bin"
      export PATH="$PATH:$SARU_PATH"

      # Zellij auto-start
      if [[ -z "$ZELLIJ" ]]; then
        zellij attach -c main options --session-serialization false --on-force-close quit
      fi
    '';
  };
}
