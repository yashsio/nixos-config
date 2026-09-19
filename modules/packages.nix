{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  # nixpkgs.config.permittedInsecurePackages = [
  # ];

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    river
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  programs.fish.enable = true;
  programs.dconf.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [ thunar-volman ];
  };

  programs.xfconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  programs.xwayland.enable = true;  
}  
