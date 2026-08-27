require("environment")

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
end)

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 3,
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
    },
    dwindle = {
        preserve_split = true,
        split_width_multiplier = 1.8,
        precise_mouse_move = true
    },
    misc = {
        middle_click_paste = true,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 3,
    },
    xwayland = {
        force_zero_scaling = true
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

require("binds")
require("rules-layer")
require("rules-windows")
require("rules-workspace")
require("inputs")

