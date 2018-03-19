local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}

local appHotkeys = {
    --{ '7', 'FirefoxDeveloperEdition' },
    --{ '8', 'Safari' },
    { 'u', 'Google Chrome' },
    --{ 'i', 'Sublime Text'},
    --{ 'i', 'Emacs' },
    --{ 'i', 'Atom' },
    --{ 'i', 'PhpStorm' },
    --{ 'i', 'MacVim' },
    { 'i', 'iTerm' },
    --{ 'o', 'Alacritty' },
    { 'y', 'Stride-alpha' },
    { 'p', 'Google Play Music Desktop Player' },
}


local mehBind = function(key, fn)
    hs.hotkey.bind(meh, key, nil, fn)
end

for i, binding in ipairs(appHotkeys) do
    local key = binding[1]
    local app = binding[2]
    local launcher = function()
        hs.application.launchOrFocus(app)
    end
    mehBind(key, launcher)
end

hs.hotkey.bind({}, 'F13', function ()
    hs.reload()
end)

hs.window.animationDuration = 0
hs.grid.setMargins({0, 0})
hs.grid.setGrid('4x4')

mehBind('a', function ()
    local win = hs.window.focusedWindow()
    win:moveOneScreenWest()
end)

mehBind('g', function ()
    local win = hs.window.focusedWindow()
    win:moveOneScreenEast()
end)

local gridHotkeys = {
    { 'w', '0,0 2x2' },
    { 'e', '0,0 4x2' },
    { 'r', '2,0 2x2' },
    { 's', '0,0 2x4' },
    { 'd', '0,0 4x4' },
    { 'f', '2,0 2x4' },
    { 'x', '0,2 2x3' },
    { 'c', '0,2 4x2' },
    { 'v', '2,2 2x2' },
    { '1', '0,0 1x4' },
    { '2', '1,0 1x4' },
    { '3', '2,0 1x4' },
    { '4', '3,0 1x4' },
}

for i, binding in ipairs(gridHotkeys) do
    local key = binding[1]
    local pos = binding[2]
    local launcher = function()
        local win = hs.window.focusedWindow()
        hs.grid.set(win, pos)
    end
    mehBind(key, launcher)
end

hs.hotkey.bind(meh, 't', function ()
    hs.grid.show()
end)
hs.hotkey.bind(hyper, 'd', function ()
    hs.grid.pushWindowDown()
end)
hs.hotkey.bind(hyper, 'f', function ()
    hs.grid.pushWindowUp()
end)
hs.hotkey.bind(hyper, 'g', function ()
    hs.grid.pushWindowRight()
end)
hs.hotkey.bind(hyper, 's', function ()
    hs.grid.pushWindowLeft()
end)
hs.hotkey.bind(hyper, 'e', function ()
    hs.grid.resizeWindowShorter()
end)
hs.hotkey.bind(hyper, 'r', function ()
    hs.grid.resizeWindowTaller()
end)
hs.hotkey.bind(hyper, 't', function ()
    hs.grid.resizeWindowWider()
end)
hs.hotkey.bind(hyper, 'w', function ()
    hs.grid.resizeWindowThinner()
end)

hs.alert.show('conf reloaded')
