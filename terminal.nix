{ pkgs, ... }:

let
  you-should-use = pkgs.fetchFromGitHub {
    owner = "MichaelAquilina";
    repo = "zsh-you-should-use";
    rev = "v1.8.0";
    sha256 = "139njh3z63vv22lq1df05w1rgknx95fj5njz31zgsm3hr7izp5bw";
  };
in
{
  programs = {
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      shellIntegration.enableZshIntegration = true;
      theme = "Catppuccin-Mocha";
    };
    zsh = {
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
      plugins = [
        {
          name = "you-should-use";
          src = you-should-use;
        }
      ];
      shellAliases = {
        gll = "git log --graph --abbrev-commit --decorate --all --date=format:'%Y-%m-%d %H:%M:%S' --format=format:'%C(bold blue)%h%C(reset) on %C(bold cyan)%ad%C(reset) %C(bold green)(%ar)%C(reset) %C(dim white)by %an%C(reset) %C(auto)%d%C(reset) %n%C(white)%s%C(reset)%n'";
      };
    };
    starship = {
      enable = true;
      settings = pkgs.lib.importTOML ./starship.toml;
    };
    fzf = {
      enable = true;
    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
    eza = {
      enable = true;
      icons = true;
      git = true;
    };
    ripgrep = {
      enable = true;
    };
    bat = {
      enable = true;
    };
    btop = {
      enable = true;
      package = pkgs.btop.override { cudaSupport = true; };
      settings = {
        theme_background = false;
      };
    };
  };
}
