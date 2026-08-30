require("environment")

-- Load plugins installed as RPMs directly, without hyprpm
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl plugin load /usr/lib64/hyprland/libhyprbars.so")
    -- re-parse the config so files gated on hl.plugin.hyprbars pick it up
    hl.exec_cmd("hyprctl reload")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("uwsm finalize")
    hl.exec_cmd("noctalia")
end)

hl.config({
    general = {
        layout = "scrolling",
        gaps_in = 5,
        gaps_out = 10,
        border_size = 3,
        allow_tearing = true,
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
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        follow_focus = true,
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
require("winbars")
require("rules-layer")
require("rules-windows")
require("rules-workspace")
require("inputs")
require("winbars")

