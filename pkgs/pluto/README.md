# pluto

A dwm-like window manager for the [river](https://isaacfreund.com/software/river/)
Wayland compositor.

River is non-monolithic: it does not ship a window manager. Instead, a separate
process implements `river-window-management-v1` and decides all window
management policy. Pluto is that process. It is the dwm model ported to river:

- **tags**, not workspaces: every window carries a bitmask and can be on several
  tags at once (`Mod+1..9`, `Mod+Ctrl+1..9`, `Mod+Shift+1..9`, `Mod+Ctrl+Shift+1..9`)
- **master/stack tiling** with a movable split (`mfact`), a variable number of
  master clients (`nmaster`), `zoom` to promote a window to master
- **layouts**: tile (`[]=`), floating (`><>`) and monocle (`[M]`)
- **compile-time configuration** in `config.h`, just like dwm
- **a tiny status IPC** so bars such as
  [pluto-bar](https://github.com/yashsio/pluto-bar) can show tags, layout and
  the focused title, and switch tags with a click
- **no bundled status bar**; run whatever bar you like, or none at all

`Mod` is `Mod4` (the Windows/Super key) by default. dwm's own default is
`Mod1`; change `MODKEY` in `config.h` if you prefer that.

## Building

Dependencies: a C99 compiler, GNU/BSD make, `wayland-scanner`, the Wayland
client library and libxkbcommon.

    make
    ./pluto

With Nix, a shell with everything you need is provided:

    nix-shell --run make

Then install it somewhere on your `$PATH`:

    make install          # respects PREFIX, default /usr/local

`config.h` is created from `config.def.h` on the first build. It is never
overwritten, so your changes survive `make clean`.

## Running it

River starts the executable `$XDG_CONFIG_HOME/river/init` (or
`~/.config/river/init`) on startup and runs the WM as a child process. A
minimal init script, equivalent to the one in this repository, is:

    #!/bin/sh
    pluto &
    wait

Start river normally (`river` from a TTY, or pick the river session in your
display manager). If a window manager is already attached, pluto exits with
`window management unavailable`.

## Status bar IPC

River 0.4 has no client-facing status or control protocol: tags are WM state.
Pluto publishes a complete per-monitor snapshot on a Unix socket at

    $XDG_RUNTIME_DIR/pluto-<WAYLAND_DISPLAY>.sock

and accepts one command. The protocol is line based, so it can be inspected
with `socat` or a few lines of Python:

    # server -> client, on connect and on every state change
    begin
    monitor <name> <focused_tags_hex> <occupied_tags_hex> <layout> <focused> <floating> <title>
    end

    # client -> server: select tags on one monitor
    view <name> <tags_hex>

Tag masks are bitmasks (`1` is tag 1, `4` is tag 3, …) and `<name>` is the
`wl_output` name. The server sends a new snapshot after `view`, so a client
does not have to guess the resulting state. `pluto-bar` speaks this protocol;
see `ipc.h` for the authoritative description.

## Key bindings

The default table is dwm's, with `Mod` = Super:

| Binding | Action |
| --- | --- |
| `Mod+Shift+Return` | spawn terminal (`foot`) |
| `Mod+p` | spawn launcher (`fuzzel`) |
| `Mod+j` / `Mod+k` | focus next / previous window in the stack |
| `Mod+Shift+c` | close focused window |
| `Mod+Shift+q` | quit (ends the river session) |
| `Mod+Return` | zoom: promote focused window to master (if it is already master, the next tiled window becomes master) |
| `Mod+h` / `Mod+l` | shrink / grow master area (`mfact`) |
| `Mod+i` / `Mod+d` | more / fewer master clients (`nmaster`) |
| `Mod+t` / `Mod+f` / `Mod+m` | tile / floating / monocle layout |
| `Mod+Space` | cycle layouts |
| `Mod+Shift+Space` | toggle floating for the focused window |
| `Mod+Shift+f` | toggle fullscreen |
| `Mod+Tab` | switch back to the previously viewed tag set |
| `Mod+1..9` | view tag |
| `Mod+Ctrl+1..9` | toggle a tag in the current view |
| `Mod+Shift+1..9` | move focused window to tag |
| `Mod+Ctrl+Shift+1..9` | toggle a tag on the focused window |
| `Mod+0` / `Mod+Shift+0` | view all tags / tag window on all tags |
| `Mod+,` / `Mod+.` | focus previous / next monitor |
| `Mod+Shift+,` / `Mod+Shift+.` | move focused window to previous / next monitor |
| `Mod+Button1` | move window (floats it first if it was tiled) |
| `Mod+Button2` | toggle floating |
| `Mod+Button3` | resize window (floats it first if it was tiled) |

Mouse and keyboard bindings live in the `keys[]` and `buttons[]` arrays in
`config.h`.

## Configuration

Everything dwm puts in `config.h` is here too:

- `borderpx`, `border_color_normal`, `border_color_focus` — dwm's
  `col_gray2`/`col_blue`
- `mfact` and `nmaster` — defaults copied into every new monitor
- `gap_inner` and `gap_outer` — gaps in pixels between tiled clients and
  between the tiled area and the screen edges; both default to `0`
- `layouts[]` — order matters: the first entry is the default
- `rules[]` — matched once against a window's `app_id` (and optionally
  `title`) when it appears; can force tags, floating state and monitor
- `lockfullscreen` — keep focus on a visible fullscreen window
- `focus_follows_pointer` — on by default: entering a window with the pointer
  focuses it (sloppy focus); clicking always focuses too
- `pointer_follows_focus` — warp the pointer to the focused window when using
  `Mod+j`/`Mod+k`; off by default, as in dwm
- `tap_to_click`, `tap_drag`, `natural_scroll` — touchpad settings, see below

Because configuration is compile-time, applying changes means `make &&`
restarting the WM (or the session). That is intentional: it is how dwm works.

## Touchpad and other input devices

River delegates libinput configuration to the window manager. A WM that does
not implement `river-libinput-config-v1` leaves libinput's defaults alone, and
on most laptops the default is that tap-to-click is **off**. Pluto applies a
small set of touchpad settings to every device that supports them:

- `tap_to_click` — tap the touchpad to click (default on)
- `tap_drag` — tap, then drag without lifting the finger (default on)
- `natural_scroll` — reverse the scroll direction (default off)

Everything else (click method, acceleration, disable-while-typing, …) is left
at the libinput default. Note that river 0.4 has no `riverctl input` command;
these settings live in `config.h` like the rest of dwm's configuration.

## Differences from dwm worth knowing

Some things cannot be translated literally from X11:

- **No bundled bar.** There is no root window to draw on and no bundled status
  text. Use a layer-shell bar (pluto-bar, waybar, sfwbar, …) or nothing.
  pluto-bar reads tags/layout from the IPC socket above.
- **Rules match `app_id`, not `WM_CLASS`.** Use the Wayland app id, e.g.
  `org.gimp.GIMP`, not `Gimp`.
- **Tags have no visual indicator** without a bar. Bindings work exactly as in
  dwm.
- **Floating windows are centred on first appearance** instead of keeping the
  position the client asked for, because Wayland clients do not get to choose
  their own position.
- **Dragging a tiled window floats it** (`Mod+Button1`/`Mod+Button3`). dwm
  would move the tiled window and let the next `arrange` snap it back, which
  is not useful here; this is the behaviour of the `tile_drag` patch.
- **Multi-monitor tags are per monitor**, as in dwm, but the tag sets start
  out identical (tag `1` on every output).
- Maximize requests are ignored and the maximize capability is not advertised,
  matching dwm. Fullscreen is supported.

## Credits

Pluto started as a fork of [JrWM](https://github.com/jpco/jrwm) by Isaac Freund
and Jack Conger, which used a BSP tree and "spaces". The client/monitor model,
layouts and key bindings have since been replaced with dwm's.

## License

GPL-3.0, see [LICENSE](LICENSE).
