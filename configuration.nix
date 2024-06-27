# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ./nvidia.nix
      ./hyprland.nix
    ];

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  time.hardwareClockInLocalTime = true;

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  environment.shells = with pkgs; [ zsh bash ];
  users.defaultUserShell = pkgs.zsh;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # Use this shell to setup IPSec: nix-shell -p networkmanagerapplet --run nm-connection-editor
  environment.etc."ipsec.secrets".text = ''
  include ipsec.d/ipsec.nm-l2tp.secrets
'';

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pajax = {
    isNormalUser = true;
    description = "Pavel Holman";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    ocs-url
    xdg-utils
    google-chrome
    git
    wayland-utils
    networkmanager
    networkmanager-l2tp
    xl2tpd
    catppuccin-kde
    kde-rounded-corners
    zsh
    zsh-you-should-use
    fzf
    alacritty
    kitty
    kitty-themes
    starship
    jetbrains-toolbox
    mono
    dotnetCorePackages.sdk_8_0_2xx
    docker
    zed-editor
    cudaPackages.cudnn
    discord
    zoxide
    omnisharp-roslyn
  ];

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "JetBrains Mono"
        ];
      };
    };
    packages = with pkgs; [
      corefonts
      inconsolata
      ubuntu_font_family
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      jetbrains-mono
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      awesome
      dejavu_fonts
      nerdfonts
      hack-font
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh = {
    enable = true;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
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

  programs.starship.enable = true;

  programs.fzf = {
    keybindings = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  virtualisation.docker.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
