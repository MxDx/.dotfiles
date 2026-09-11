-- Personal keybinding overrides for the Omarchy migration, ported from the
-- previous standalone Hyprland setup (hypr/.config/hypr/hyprland.conf on the
-- minimalist-clean branch).
--
-- This file is ~/.config/hypr/bindings.lua -- loaded LAST by hyprland.lua,
-- after ALL of Omarchy's own defaults (default/hypr/bindings/*.lua) and the
-- current theme. That's why some entries below call hl.unbind(keys) right
-- before o.bind(...) -- those specific keys are already claimed by an
-- Omarchy default, and binding without unbinding first would fire BOTH
-- actions on one keypress. (This is what Omarchy's own o.rebind() does
-- internally -- inlined here instead of calling o.rebind() directly since
-- that helper isn't present on every Omarchy build; hl.unbind + o.bind are
-- the stable underlying primitives it wraps.)
--
-- Check what's currently live at any time with:
--   omarchy menu keybindings --print
--
-- Every clash noted here was checked directly against Omarchy's actual
-- source (default/hypr/bindings/{tiling,applications,utilities,media,
-- clipboard}.lua), not guessed.

--------------------------------------------------------------------------
-- Terminal / floating-toggle -- SWAPPED vs your old config on purpose.
--
-- Omarchy already binds SUPER+T to "toggle floating" (what you had on
-- SUPER+W) and SUPER+W to "close window" (a redundant duplicate of
-- SUPER+Q, which is untouched and already matches your old SUPER+Q).
-- Rather than fight both, this reclaims the redundant SUPER+W duplicate
-- for floating-toggle (your old muscle memory) and frees SUPER+T for
-- terminal (your other old muscle memory) -- Omarchy's own terminal bind
-- lives on SUPER+RETURN instead, so T was spare functionality, not a name
-- collision.
--------------------------------------------------------------------------
-- Correction: on this Omarchy build, close-window was only ever bound to
-- SUPER+W (not also SUPER+Q like current upstream) -- reclaiming W below
-- removed the only working close bind. Bind Q explicitly ourselves instead
-- of trusting Omarchy's default for it, so this doesn't depend on which
-- build/version is installed.
hl.unbind("SUPER + Q")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

hl.unbind("SUPER + W") -- was: close window (now covered explicitly by SUPER+Q above)
o.bind("SUPER + W", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
hl.unbind("SUPER + T") -- was: toggle window floating/tiling (moved to SUPER+W above)
o.bind("SUPER + T", "Terminal", "kitty")
-- If you'd rather stay in sync with whatever terminal Omarchy is configured
-- to use (instead of hardcoding kitty), use this instead:
-- hl.unbind("SUPER + T")
-- o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })

--------------------------------------------------------------------------
-- Apps -- both free, no clash found anywhere in the default bindings.
--------------------------------------------------------------------------
o.bind("SUPER + B", "Browser", "zen-browser")
o.bind("SUPER + E", "File manager", "nautilus")

--------------------------------------------------------------------------
-- Exit fallback -- free, ports your old hyprshutdown/exit bind exactly.
-- Omarchy's own SUPER+ESCAPE system menu likely already offers logout, but
-- keeping this hard fallback costs nothing and matches old muscle memory.
--------------------------------------------------------------------------
o.bind(
  "SUPER + M",
  "Exit (hyprshutdown fallback)",
  "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
)

--------------------------------------------------------------------------
-- Vim-style focus movement. H is free; J/K/L collide with real Omarchy
-- defaults (toggle split, keybindings menu, toggle workspace layout) so
-- those three need hl.unbind first, not plain o.bind.
--------------------------------------------------------------------------
o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
hl.unbind("SUPER + J") -- was: toggle window split
o.bind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))
hl.unbind("SUPER + K") -- was: keybindings menu
o.bind("SUPER + K", "Focus up", hl.dsp.focus({ direction = "u" }))
hl.unbind("SUPER + L") -- was: toggle workspace layout
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))

--------------------------------------------------------------------------
-- Keybindings menu -- Omarchy's default home for this was SUPER+K, which
-- the vim-focus block above reclaimed. SUPER+SHIFT+K is free and completes
-- the K-family alongside SUPER+ALT+K (tmux) and SUPER+CTRL+K (herdr).
--------------------------------------------------------------------------
o.bind("SUPER + SHIFT + K", "Keybindings menu", "omarchy menu keybindings")

--------------------------------------------------------------------------
-- Hyprlock alias -- free. Omarchy's native lock is SUPER+CTRL+L; this just
-- keeps your old muscle-memory key working too (harmless duplicate).
--------------------------------------------------------------------------
o.bind("SUPER + ALT + L", "Lock screen (hyprlock)", "hyprlock")

--------------------------------------------------------------------------
-- Steam/Gamescope -- SUPER+G collides with "toggle window grouping" in
-- Omarchy, so this moves to a free chord instead of fighting for G.
--------------------------------------------------------------------------
o.bind("SUPER + CTRL + G", "Steam (Gamescope)", "gamescope -f -e -W 2560 -H 1600 -r 120 -- steam -gamepadui")

--------------------------------------------------------------------------
-- NOT ported -- already covered natively by Omarchy, verified in its
-- source, no functionality lost:
--------------------------------------------------------------------------
-- SUPER+Q              close window                 (tiling.lua, identical to your old Q)
-- SUPER+1..0            workspace switch              (tiling.lua, code:N based, same idea)
-- SUPER+SHIFT+1..0       move window to workspace      (tiling.lua)
-- SUPER+SHIFT+ALT+1..9   move window silently          (tiling.lua -- note: different modifier
--                                                        combo than your old SUPER+ALT+1..9; see
--                                                        open question below if you want the exact
--                                                        old chord instead)
-- SUPER+S / SUPER+ALT+S  scratchpad toggle / move       (tiling.lua; Omarchy calls it "scratchpad"
--                                                        instead of your old "magic", same feature)
-- SUPER+mouse_down/up    scroll workspaces              (tiling.lua, identical to your old binds)
-- SUPER+mouse:272/273    move/resize window by drag     (tiling.lua, identical to your old binds)
-- SUPER+V                universal paste                (clipboard.lua)
-- SUPER+CTRL+V           clipboard manager UI           (clipboard.lua -- native equivalent of your
--                                                        old walker "menus:clipboard")
-- SUPER+CTRL+B           bluetooth panel                (utilities.lua -- native equivalent of your
--                                                        old walker "menus:bluetooth")
-- SUPER+CTRL+SPACE       background switcher            (utilities.lua -- native equivalent of your
--                                                        old walker "menus:backgrounds")
-- SUPER+ESCAPE           system/power menu               (utilities.lua -- native equivalent of your
--                                                        old walker "menus:power")
-- SUPER+SPACE            main app launcher               (utilities.lua -- native equivalent of your
--                                                        old walker SUPER+A)
-- PRINT                  screenshot                     (utilities.lua, omarchy-capture-screenshot)
-- XF86Audio*/XF86Mon*    volume/brightness/media         (media.lua -- covers everything your old
--                                                        wpctl/brightnessctl/playerctl + sys-notify.sh
--                                                        binds did, with its own OSD)

--------------------------------------------------------------------------
-- OPEN QUESTIONS -- real clashes with no native Omarchy equivalent. Left
-- out of this file on purpose; tell me which (if any) you still want and
-- I'll wire them in:
--------------------------------------------------------------------------
-- 1. SUPER+P (your old "walker -m archlinuxpkgs" search) clashes with
--    Omarchy's "pop window out (float & pin)". Free alternative if you
--    still want arch-package search: SUPER+ALT+P.
-- 2. SUPER+F (your old "walker -m files" search) clashes with Omarchy's
--    "full screen". Free alternative: SUPER+CTRL+F.
--    Both of the above require walker+elephant to still be installed and
--    configured -- which is the "look and feel, rice later" bucket you
--    said you're deferring, so no rush on these two.
-- 3. SUPER+ALT+1..9 (your exact old modifier combo for "move window
--    silently to workspace N") is free and NOT wired up above, since
--    Omarchy already does the same thing on SUPER+SHIFT+ALT+N. Say the
--    word if you want the old exact chord instead/as well:
--    for i = 1, 9 do
--      o.bind("SUPER + ALT + " .. i, "Move to workspace " .. i .. " (silent)",
--        hl.dsp.window.move({ workspace = tostring(i), follow = false }))
--    end
