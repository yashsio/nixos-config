{ ... }: {
  security.apparmor.enable = true;

  security.rtkit.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.hyprlock = {};

}
