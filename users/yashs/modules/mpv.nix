{ pkgs, ... }:

{
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
}


