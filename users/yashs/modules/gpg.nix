{ pkgs, ... }:

{
  programs.gpg.enable = true; 

  services.gpg-agent = {
    enable = true;
  
    pinentry.package = pkgs.pinentry-curses;
  
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
  
    enableSshSupport = true;
    defaultCacheTtlSsh = 34560000;
    maxCacheTtlSsh = 34560000;
  
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
} 

