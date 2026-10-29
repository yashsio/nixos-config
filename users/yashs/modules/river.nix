# river.nix
{ ... }:

{
  wayland.windowManager.river = {
    enable = true;

    extraConfig = ''
      # The user D-Bus session is shared across login sessions and TTYs.
      # Only update it from the first Wayland session.
      if [ "$WAYLAND_DISPLAY" = "wayland-1" ]; then
        dbus-update-activation-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP PATH
        systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      fi

      timestamp=$(date +%F-%R)
      pluto >/tmp/pluto-$timestamp.log 2>&1 &

      pluto-status | pluto-bar &
      foot --server &
      mako &
      swaybg -m fill -i "$(cat "$HOME/.local/state/wallpaper")" &
      wl-paste --type text --watch cliphist store &
      wl-paste --type image --watch cliphist store &
      wlsunset -l 28.65 -L 77.20 &
    '';
  };
}

