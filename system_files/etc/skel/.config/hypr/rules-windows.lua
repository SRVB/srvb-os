hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

-- Picture-in-Picture
hl.window_rule({
    match             = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float             = true,
    keep_aspect_ratio = true,
    size              = { "max(monitor_w, monitor_h)*0.25", "min(monitor_w, monitor_h)*0.25" },
    pin               = true,
})

-- Opacity Overrides
local terminals = "^(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)$"

hl.window_rule({ match = { class = "^(firefox|zen)$" }, opacity = "1.0 override" })
hl.window_rule({ match = { class = terminals }, opacity = "1.0 override" }) -- Override opacity in favor of terminal settings for opacity. If your terminal doesn't support transparency, you can remove this rule.

-- Gaming
hl.window_rule({
    match = { content = "game" },
    immediate = true,
    idle_inhibit = "fullscreen",
    no_anim = true,
    no_blur = true,
    no_shadow = true,
    border_size = 0,
    rounding = 0,
})

-- fullscreen_state_internal = 2 is "real" fullscreen; maximize (1) keeps rounding/shadow
hl.window_rule({
    match = { xwayland = true, fullscreen_state_internal = 2 },
    immediate = true,
    idle_inhibit = "fullscreen",
    no_anim = true,
    no_blur = true,
    no_shadow = true,
    border_size = 0,
    rounding = 0,
})

hl.window_rule({
    match = { fullscreen_state_internal = 2 },
    no_anim = true,
    no_blur = true,
    no_shadow = true,
    border_size = 0,
    rounding = 0,
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
