{ ... }:

{
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
}


