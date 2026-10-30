{ inputs, currentSystemName, ... }:

{ lib, pkgs, ... }:

{
  imports =
  [
    ./modules/bash.nix
    ./modules/cliphist.nix
    ./modules/direnv.nix
    ./modules/fastfetch.nix
    ./modules/fish.nix
    ./modules/foot.nix
    ./modules/fuzzel.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/gtk.nix
    ./modules/jujutsu.nix
    ./modules/librewolf.nix
    #./modules/neovim.nix
    ./modules/qt.nix
    ./modules/river.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/xdg.nix
  ] ++ lib.optionals (currentSystemName == "host") [
    ./modules/keepassxc.nix
    #./modules/kitty.nix
    ./modules/libreoffice.nix
    ./modules/mako.nix
    ./modules/mpv.nix
    ./modules/obs-studio.nix
    ./modules/swaylock.nix
    ./modules/wlsunset.nix
    ./modules/zathura.nix
  ] ++ lib.optionals (currentSystemName == "vm") [
  ];

  home.stateVersion = "26.05";

  home.enableNixpkgsReleaseCheck = false;

  # Packages
  home.packages = with pkgs; [
    nur.repos.yashsio.krypton-cli
    nur.repos.yashsio.aether

    zip
    unzip

    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    clang
    clang-tools
    cmake
    gnumake
    pkg-config

    tree-sitter
    ripgrep
    fd
    fzf
    jq

    python3
    uv
    
    wl-clipboard
    qt6.qtwayland
    curl
    neovim
    swaybg
  ] ++ (lib.optionals (currentSystemName == "vm") [
    opencode
  ]) ++ (lib.optionals (currentSystemName == "host") [
    brave-origin
    gimp
    podman-compose
    cmatrix
    pavucontrol
    playerctl
    brightnessctl
    libnotify
    grim 
    slurp
    htop
    imagemagick
  ]);


  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim"; 
  };

  home.file.".local/bin/" = {
    source = ./scripts;
    recursive = true;
  }; 

  home.file.".config/kdeglobals".text = ''
    [Icons]
    Theme=Gruvbox-Plus-Dark
  '';

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Original-Ice";
    package = pkgs.bibata-cursors;
  }; 
}
