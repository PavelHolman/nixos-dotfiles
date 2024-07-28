{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
  ];

  home.username = "pajax";
  home.homeDirectory = "/home/pajax";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  home.packages = with pkgs; [
    zip
    unzip
    xdg-utils

    ripgrep
    eza
    fzf

    zoxide
    starship
  ];

  home.file = {};

  home.sessionVariables = {};

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "rust"
        "aliases"
        "docker"
      ];
    };
    shellAliases = {
      gll = "git log --graph --abbrev-commit --decorate --all --date=format:'%Y-%m-%d %H:%M:%S' --format=format:'%C(bold blue)%h%C(reset) on %C(bold cyan)%ad%C(reset) %C(bold green)(%ar)%C(reset) %C(dim white)by %an%C(reset) %C(auto)%d%C(reset) %n%C(white)%s%C(reset)%n'";
    };
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
  programs.kitty = {
    enable = true;
    font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Mocha";
  };

  programs.fzf = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.home-manager.enable = true;
}
