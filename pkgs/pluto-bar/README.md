pluto-bar
=========

A dwm-style status bar for Hyprland and river.  Suckless rules apply: one
small C binary, no runtime config, no daemon, no command line options.  Edit
`config.h`, recompile, done.

It is a `wlr-layer-shell` client.  The drawing code is a port of dwm's
`drawbar()` to cairo/pango: nine clickable tags on the left, the layout
symbol, the focused window title (with the blue `SchemeSel` block on the
focused monitor), and the status text on the right.  Tag clicks switch
Hyprland workspaces or river tags.

Hyprland state comes from its IPC sockets.  River 0.4 has no client-facing
status/control protocol (tags belong to the window manager), so the river
backend talks to the small status socket published by
[pluto](https://github.com/yashsio/pluto), the dwm-like WM this bar was
written for.  The bar auto-detects which compositor it is running under.

Build
-----

With the provided Nix flake:

    nix develop
    make
    ./pluto-bar

(`make install` puts it in `/usr/local/bin` by default.)

Or build/install it as a Nix package:

    nix build .#          # ./result/bin/pluto-bar
    nix profile install . # puts pluto-bar in ~/.nix-profile/bin

Without Nix, install `wayland`, `cairo`, `pango`, `fontconfig`,
`wayland-protocols`/`wlr-protocols`, then:

    make WLR_PROTOCOLS=/usr/share/wlr-protocols

The build only needs `wlr-layer-shell-unstable-v1.xml` from `wlr-protocols`;
`wayland-scanner` generates the client glue in `protocols/`.

Run it from Hyprland
--------------------

Classic Hyprland config:

    exec-once = pluto-bar

This user's Lua-style config:

    hl.on("hyprland.start", function()
        hl.exec_cmd("pluto-bar")
    end)

With the included status script (install it with `make install` or the
flake, or run it from the repo):

    exec-once = sh -c 'pluto-status | pluto-bar'

    hl.exec_cmd("sh -c 'pluto-status | pluto-bar'")

Run it from river
-----------------

River 0.4 is non-monolithic: tags, layouts and the focused window are owned
by the window manager, not the compositor.  pluto therefore publishes a
per-monitor snapshot on

    $XDG_RUNTIME_DIR/pluto-<WAYLAND_DISPLAY>.sock

and accepts `view <monitor> <tagmask>` commands on it.  `pluto-bar` connects
to that socket automatically when it sees river's globals on the registry.
The socket path and line format are documented in pluto's `ipc.h`.

Start pluto and the bar from river's init script:

    ~/.config/river/init:

        #!/bin/sh
        pluto &
        sh -c 'pluto-status | pluto-bar' &
        wait

or add the bar to an existing init that already starts pluto:

        sh -c 'pluto-status | pluto-bar' &

The bar uses `zwlr_layer_shell_v1`, which river supports.  If the socket does
not exist yet (the two processes raced at startup), the bar retries once per
second.

The bar reserves `bh` pixels at the top of every monitor through the
layer-shell exclusive zone, so tiled windows start below it.  **Disable
any other bar** (waybar, noctalia's bar, ...) before starting pluto-bar,
otherwise you get two bars stacked on top of each other.

On this machine noctalia also draws a bar at the top.  Turn that off in
noctalia's settings (or stop noctalia) if you want pluto-bar to sit at
y=0.

Status text
-----------

dwm reads status from the root window name (`xsetroot -name`).  Wayland has
no root window, so pluto-bar reads newline-separated status from **stdin**.
The last line becomes the status text.

    # the included script: music, CPU, RAM, battery, clock
    ./status.sh | pluto-bar

    # when installed (Makefile / flake), it is on PATH as pluto-status
    pluto-status | pluto-bar

`status.sh` is plain POSIX sh.  It needs `date`, `sleep`, `cut` and
`timeout` from coreutils, reads `/proc` and `/sys`, and uses `playerctl`
only if it is installed.  Edit the `add()` calls at the bottom to change
the modules or their order.  Keep the clock last: the bar right-aligns
the whole line and ellipsizes its right end.

If stdin is a terminal or `/dev/null` (which is what happens when the
compositor or WM starts the bar without a pipe), no status is read and
pluto-bar shows the built-in clock formatted with `clockfmt` from
`config.h`.

Configuration
-------------

Everything is in `config.h`.  There is no runtime configuration file; any
old `~/.config/pluto-bar/config` is ignored, suckless style.

* `font` - a Pango/Fontconfig font string, default
  `"Iosevka Nerd Font 13px"`.  Pango handles glyph fallback.
* `tags` - labels for tags 1-9, matching dwm.  Index *i* maps to tag
  *i+1* (Hyprland workspace *i+1*); the default is `1 2 3 4 5 6 7 8 9`.
  Labels can be any string (numbers, icons, words).  Hyprland workspace 10
  still exists (mod+0) but has no tag and is not shown.
* `ltsymbol` - the text between tags and title.  dwm shows the active
  layout here.  Hyprland has no dwm layouts, so under Hyprland this is the
  static classic tile symbol `"[]="` by default; set it to `""` to leave the
  cell empty.  Under river the WM's current layout symbol (e.g. `[]=`, `><>`,
  `[M]`) replaces it.  The cell is always reserved, as in dwm.
* `clockfmt` - `strftime` format for the built-in clock.
* `colors` - `{ foreground, background }` for `SchemeNorm` and `SchemeSel`,
  exactly like dwm.  `SchemeSel` is the selected tag and the title block.
  Colours accept `#rgb`, `#rrggbb` and `#aarrggbb`.

Bar height and padding follow dwm: `bh = font height + 2`, and
`lrpad = font height`.

Notes / limitations
-------------------

* Tags cover tags/workspaces 1-9.  Hyprland workspace 10 (and IDs outside
  1-9) is not drawn.
* Only the focused monitor gets the window title and the status text,
  just like dwm only draws status on the selected monitor.  Other
  monitors show their tags and nothing else.
* Under Hyprland, tag clicks switch to workspace *N* (Lua API, with the
  legacy dispatcher as a fallback); on a multi-monitor setup an existing
  workspace on another monitor will take focus there.
* Under river, tag clicks ask pluto to view tag *N* on the clicked monitor.
  The river backend requires pluto's status socket; running another WM means
  the tags stay empty, because river 0.4 gives clients no way to inspect WM
  state.  River 0.3's old `river-status`/`river-control` protocols are not
  used.
* No tray, no tooltips, no modules, no mouse-drag, no D-Bus.  That is the
  point.
* Text is ellipsized with Pango (`...` becomes U+2026 when the font has
  it), everything else matches dwm's geometry.
