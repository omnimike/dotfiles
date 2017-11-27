local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}

local appHotkeys = {
    { '7', 'FirefoxDeveloperEdition' },
    { '8', 'Safari' },
    { 'u', 'Google Chrome' },
    --{ 'i', 'Sublime Text'},
    --{ 'i', 'Emacs' },
    --{ 'i', 'Atom' },
    --{ 'i', 'PhpStorm' },
    --{ 'i', 'MacVim' },
    { 'i', 'iTerm' },
    { 'o', 'Alacritty' },
    { 'y', 'Slack' },
    { 'p', 'Google Play Music Desktop Player' },
}


local hyperBind = function(key, fn)
    hs.hotkey.bind(hyper, key, nil, fn)
end

for i, binding in ipairs(appHotkeys) do
    local key = binding[1]
    local app = binding[2]
    local launcher = function()
        hs.application.launchOrFocus(app)
    end
    hyperBind(key, launcher)
end

hs.hotkey.bind({}, 'F12', function ()
    hs.caffeinate.lockScreen()
end)

hs.hotkey.bind({}, 'F13', function ()
    hs.reload()
end)

hs.window.animationDuration = 0
hs.grid.setMargins({0, 0})
hs.grid.setGrid('6x6')

hyperBind('a', function ()
    local win = hs.window.focusedWindow()
    win:moveOneScreenWest()
end)

hyperBind('g', function ()
    local win = hs.window.focusedWindow()
    win:moveOneScreenEast()
end)

local gridHotkeys = {
    { 'w', '0,0 3x3' },
    { 'e', '0,0 6x3' },
    { 'r', '3,0 3x3' },
    { 's', '0,0 3x6' },
    { 'd', '0,0 6x6' },
    { 'f', '3,0 3x6' },
    { 'x', '0,3 3x3' },
    { 'c', '0,3 6x3' },
    { 'v', '3,3 3x3' },
}

for i, binding in ipairs(gridHotkeys) do
    local key = binding[1]
    local pos = binding[2]
    local launcher = function()
        local win = hs.window.focusedWindow()
        hs.grid.set(win, pos)
    end
    hyperBind(key, launcher)
end

hs.alert.show('conf reloaded')
