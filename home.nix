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

    ripgrep
    eza
    fzf

    alacritty
    zoxide
    starship
  ];

  home.file = {};

  home.sessionVariables = {};

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
  programs.alacritty = {
    enable = true;

    settings = {
      font.normal = {
        family = "JetBrains Mono Nerd Font";
        style = "Regular";
      };

      window = {
        dynamic_padding = true;
        opacity = 0.9;
        blur = true;
      };

      selection.save_to_clipboard = true;
      cursor.style.blinking = "On";
    };
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

  programs.fzf.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.home-manager.enable = true;
}
