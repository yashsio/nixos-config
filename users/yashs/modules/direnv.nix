{ config, ... }:

{
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
}
