{ ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      font_size = 14;
      font_family = "DejaVu Sans Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      cursor_shape = "beam";
      cursor_trail = 1;

      window_margin_width = "10 15";
      window_resize_step_cells = 5;
      window_resize_step_lines = 2;
      confirm_os_window_close = 0;

      background_opacity = 0.9;
      background_blur = 0;

      enable_audio_bell = false;
      force_ltr = false;
      detect_urls = true;
    };

    keybindings = {
      "ctrl+equal" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+backspace" = "change_font_size all 0";
    };
  };
}

