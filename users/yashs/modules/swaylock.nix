{ ... }:

{
  programs.swaylock = {
    enable = true;

    settings = {
      color = "1d2021";

      indicator-radius = 52;
      indicator-thickness = 6;
      indicator-idle-visible = true;

      dim-layer = 0.6;

      inside-color = "1d2021d9";
      ring-color = "689d6aff";
      text-color = "ebdbb2ff";
      line-color = "00000000";

      # Cleared field
      inside-clear-color = "1d2021d9";
      ring-clear-color = "a89984ff";
      text-clear-color = "a89984ff";
      line-clear-color = "00000000";

      # Verifying
      inside-ver-color = "1d2021d9";
      ring-ver-color = "d79921ff";
      text-ver-color = "ebdbb2ff";
      line-ver-color = "00000000";

      # Wrong password
      inside-wrong-color = "282828b3";
      ring-wrong-color = "cc241dff";
      text-wrong-color = "fbf1c7ff";
      line-wrong-color = "00000000";

      # Caps Lock
      inside-caps-lock-color = "1d2021d9";
      ring-caps-lock-color = "d79921ff";
      text-caps-lock-color = "d79921ff";
      caps-lock-key-hl-color = "d79921ff";
      caps-lock-bs-hl-color = "d79921ff";

      key-hl-color = "a89984ff";
      bs-hl-color = "cc241dff";
      separator-color = "1d2021ff";

      font = "Iosevka Nerd Font";
      font-size = 15;

      layout-bg-color = "282828e6";
      layout-border-color = "50494566";
      layout-text-color = "d5c4a1c2";

      ignore-empty-password = true;
      show-failed-attempts = true;
      daemonize = true;
    };
  };
}   
