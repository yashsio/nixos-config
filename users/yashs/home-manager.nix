{ inputs, ... }:

{ config, lib, pkgs, pkgsUnstable, ... }:

let
  nixConfigPath = "${config.home.homeDirectory}/nixos-config";

  shellAliases = {
    ga = "git add";
    gc = "git commit";
    gco = "git checkout";
    gcp = "git cherry-pick";
    gdiff = "git diff";
    gl = "git prettylog";
    gp = "git push";
    gs = "git status";
    gt = "git tag";

    jd = "jj desc";
    jf = "jj git fetch";
    jn = "jj new";
    jp = "jj git push";
    js = "jj st";

    nixos-switch = "sudo nixos-rebuild switch --flake ${nixConfigPath}#host";
    nixos-test = "sudo nixos-rebuild test --flake ${nixConfigPath}#host";
    nixos-boot = "sudo nixos-rebuild boot --flake ${nixConfigPath}#host";
    switch-vm = "sudo nixos-rebuild switch --flake ${nixConfigPath}#vm";
    test-vm = "sudo nixos-rebuild test --flake ${nixConfigPath}#vm";
    boot-vm = "sudo nixos-rebuild boot --flake ${nixConfigPath}#vm";
    cleanup = "sudo nix-collect-garbage -d";
  };


in {
  home.stateVersion = "26.05";

  home.enableNixpkgsReleaseCheck = false;

  xdg.enable = true;

  # Packages
  home.packages = with pkgs; [
    nur.repos.yashsio.mozart
    nur.repos.yashsio.krypton-cli

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
    
    foot
    tmux
    imagemagick
    fastfetch
    gimp
    podman-compose
    vlc
    cmatrix
    cliphist
    wl-clipboard
    pavucontrol
    playerctl
    mako
    waybar
    fuzzel
    librewolf
    zathura
    kdePackages.gwenview
    kdePackages.ark
    marktext
    qt6.qtwayland
    brightnessctl
    libreoffice
    curl
    swaybg
    hyprsunset
    libnotify
    grim 
    slurp
    htop
    cava
    hypridle
  ] ++ [
    pkgsUnstable.brave-origin
    pkgsUnstable.zig
  ];

  # Env vars and dotfiles

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
    Theme=Papirus
  ''; 

  xdg.configFile = {
    "starship.toml".source = ./starship;
    "hypr".source = ./hypr;
    "nvim".source = ./nvim;
    "fastfetch/config.jsonc".source = ./fastfetch;
    "foot/foot.ini".source = ./foot;
    "fuzzel/fuzzel.ini".source = ./fuzzel;
    "mako/config".source = ./mako;
    "waybar".source = ./waybar;
    "tmux/tmux.conf".source = ./tmux;
    "zathura/zathurarc".source = ./zathurarc;
  };

  xdg.desktopEntries.neovim = {
    name = "Neovim";
    genericName = "Text Editor";
    comment = "Edit files";
    exec = "footclient nvim %F";
    terminal = false;
    type = "Application"; 
    icon = "nvim";
    categories = [ "Development" "TextEditor" ];
    mimeType = [
      "text/plain"
      "text/x-c"
      "text/x-c++"
      "text/x-python"
    ];
  };
  

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Original-Ice";
    package = pkgs.bibata-cursors;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme; 
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";

    qt5ctSettings = {
      Appearance.icon_theme = "Papirus";
    };

    qt6ctSettings = {
      Appearance.icon_theme = "Papirus";
    };
  };

  # Programs

  programs.gpg.enable = true;

  programs.starship = {
    enable = true;

    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = [ "ignoredups" "ignorespace" ];
    shellAliases = shellAliases;
  };

  programs.direnv= {
    enable = true;

    config = {
      whitelist = {
        prefix= [
          "${config.home.homeDirectory}/code"
        ];

        exact = ["${config.home.homeDirectory}/.envrc"];
      };
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = shellAliases;
    interactiveShellInit = ''
      if status is-interactive
        fastfetch
      end
    '';
    functions = {
      fish_greeting = {
        body = "";
      };
      hl = {
        body = ''
          start-hyprland $argv
        '';
      };
      nixos-check = {
        body = ''
          nix flake check "$HOME/nixos-config" --all-systems --no-build; or return 1

          nix eval --raw \
            "$HOME/nixos-config#nixosConfigurations.host.config.system.build.toplevel.drvPath" \
            >/dev/null; or return 1

          nix eval --raw \
            "$HOME/nixos-config#nixosConfigurations.vm.config.system.build.toplevel.drvPath" \
            >/dev/null; or return 1

          echo "NixOS configurations are valid."
        '';
      };
    }; 
  };

  programs.git = {
    enable = true;
    signing = {
      key = "FC8FCCEB9A39DA92";
      signByDefault = true;
    };
    settings = {
      user.name = "Yash Sharma";
      user.email = "296458454+yashsio@users.noreply.github.com";
    };
  }; 

  programs.jujutsu = {
    enable = false;
  };
  
  programs.neovim = {
    enable = true;
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    initLua = ''
      require("config.lazy")
    '';
  }; 

  programs.hyprlock.enable = true; 
}
