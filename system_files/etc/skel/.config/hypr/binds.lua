local mainMod = "SUPER"
local ipc = "noctalia msg "
local terminal = "kitty"

-- Core binds
hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind(mainMod .. "+Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "+E", hl.dsp.exec_cmd("nautilus"))
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region --raw | swappy -f -"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Window management and navigation
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. "+F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. "+V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }))

-- Move the active window with Shift and resize it with CTRL
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. "+CTRL+H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mainMod .. "+CTRL+L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. "+CTRL+K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mainMod .. "+CTRL+J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- Workspaces
for workspace = 1, 9 do
    hl.bind(mainMod .. "+" .. workspace, hl.dsp.focus({ workspace = workspace }))
    hl.bind(mainMod .. "+SHIFT+" .. workspace, hl.dsp.window.move({ workspace = workspace }))
end
hl.bind(mainMod .. "+0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. "+SHIFT+0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mainMod .. "+mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. "+mouse_up", hl.dsp.focus({ workspace = "m-1" }))

-- Session
hl.bind(mainMod .. "+M", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. "+SHIFT+R", hl.dsp.exec_cmd("hyprctl reload"))
