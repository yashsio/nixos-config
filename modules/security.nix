{ pkgs, lib, ... }: {

  # security.apparmor = {
  #   enable = true;
  #   enableCache = true;
  #   killUnconfinedConfinables = true;
  #   policies = {
  #     brave = {
  #       state   = "complain";
  #       profile = ''
  #         abi <abi/4.0>,
  #         include <tunables/global>
  #
  #         profile brave ${pkgs.brave}/bin/brave flags=(attach_disconnected) {
  #           include <abstractions/base>
  #           include <abstractions/audio>
  #           include "${pkgs.apparmor-d}/etc/apparmor.d/groups/browsers/brave"
  #
  #           /nix/store/** r,
  #           /nix/store/** mr,
  #           /nix/store/**/lib/** mr,
  #
  #           owner @{HOME}/.config/BraveSoftware/** rw,
  #           owner @{HOME}/.config/BraveSoftware/**/ rw,
  #           owner @{HOME}/.cache/BraveSoftware/** rw,
  #           owner @{HOME}/.cache/BraveSoftware/**/ rw,
  #         }
  #       '';
  #     };
  #   };
  # };
  # environment.systemPackages = with pkgs; [
  #   apparmor-parser
  # ];
  #
  # specialisation."no-apparmor".configuration = {
  #   security.apparmor.enable = lib.mkForce false;
  # };
  #
  # services.dbus.apparmor = "enabled";

  security.rtkit.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.hyprlock = {};

}
