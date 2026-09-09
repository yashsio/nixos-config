{ pkgs, ... }:

{
  users.users.yashs = {
    isNormalUser = true;
    home = "/home/yashs";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
    shell = pkgs.fish; 
  };
}
