{ inputs, currentSystemName, ... }:

{ config, lib, pkgs, ... }:

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

    ff = "fastfetch";

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
    
    fastfetch 
    foot
    cliphist
    wl-clipboard
    fuzzel
    qt6.qtwayland
    curl
    swaybg
    neovim
    tmux
  ] ++ (lib.optionals (currentSystemName == "vm") [
    opencode
  ]) ++ (lib.optionals (currentSystemName == "host") [
    obs-studio
    gimp
    podman-compose
    cmatrix
    pavucontrol
    playerctl
    mako
    brightnessctl
    libreoffice
    libnotify
    grim 
    slurp
    htop
    cava
    zathura
    imagemagick
    wlsunset
    keepassxc
  ]);

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
    Theme=Gruvbox-Plus-Dark
  ''; 

  xdg.configFile = {
    "starship.toml".source = ./starship;
    "hypr".source = ./hypr;
    "nvim".source = ./nvim;
    "fastfetch/config.jsonc".source = ./fastfetch;
    "foot/foot.ini".source = ./foot;
    "kitty/kitty.conf".source = ./kitty;
    "fuzzel/fuzzel.ini".source = ./fuzzel;
    "mako/config".source = ./mako;
    "waybar".source = ./waybar;
    "swaylock/config".source = ./swaylock;
    "tmux/tmux.conf".source = ./tmux;
    "river/init".source = ./river-init;
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
    colorScheme = "dark";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
 
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons.override {
        folder-color = "pistachio";
      };
    }; 
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";

    qt5ctSettings = {
      Appearance.icon_theme = "Gruvbox-Plus-Dark";
    };

    qt6ctSettings = {
      Appearance.icon_theme = "Gruvbox-Plus-Dark";
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
      end
    '';
    functions = {
      fish_greeting = {
        body = '' 
        '';
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
      diff.tool = "nvimdiff";
      difftool.prompt = false;
      difftool.nvimdiff.cmd = ''nvim -d "$LOCAL" "$REMOTE"'';
    };
  }; 

  programs.jujutsu = {
    enable = true;
  };

  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
        thumbfast
        mpris
      ];
    };
    config = {
      vo = "gpu-next";
      gpu-api = "vulkan";
      hwdec = "auto";

      profile = "high-quality";
      sub-auto = "fuzzy";
      slang = "eng,en";

      save-position-on-quit = true;
      ytdl-format = "bestvideo+bestaudio";

      cache-default = 4000000;
    };
    bindings = {
      WHEEL_UP = "seek 5";
      WHEEL_DOWN = "seek -5";
      "Alt+0" = "set window-scale 0.5";
    };
  };

  programs.librewolf = {
    enable = true;
    settings = {
      "browser.startup.page" = 3;                        
      "privacy.clearOnShutdown.history" = false;    
      "privacy.clearOnShutdown.openWindows" = false;
      "privacy.clearOnShutdown.sessions" = false;

      "network.trr.mode" = 2;
      "network.trr.uri" = "https://dns.quad9.net/dns-query";
    };
  };  

  programs.swaylock.enable = true; 
}
