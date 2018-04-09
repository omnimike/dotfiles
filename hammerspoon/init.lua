local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}

local appHotkeys = {
    { 'u', 'Google Chrome' },
    { 'i', 'iTerm' },
    { 'y', 'Stride-alpha' },
    { 'o', 'IntelliJ IDEA' },
    { 'p', 'Google Play Music Desktop Player' },
}


local mehBind = function(key, fn)
    hs.hotkey.bind(meh, key, nil, fn)
end

local hyperBind = function(key, fn)
    hs.hotkey.bind(hyper, key, nil, fn)
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

local mehGridHotkeys = {
    { 'w', '0,0 2x2' },
    { 'e', '0,0 4x2' },
    { 'r', '2,0 2x2' },
    { 's', '0,0 2x4' },
    { 'd', '0,0 4x4' },
    { 'f', '2,0 2x4' },
    { 'x', '0,2 2x3' },
    { 'c', '0,2 4x2' },
    { 'v', '2,2 2x2' },
}

for i, binding in ipairs(mehGridHotkeys) do
    local key = binding[1]
    local pos = binding[2]
    local launcher = function()
        local win = hs.window.focusedWindow()
        hs.grid.set(win, pos)
    end
    mehBind(key, launcher)
end

local hyperGridHotkeys = {
    { 'w', '0,0 1x2' },
    { 'e', '1,0 2x2' },
    { 'r', '3,0 1x2' },
    { 's', '0,0 1x4' },
    { 'd', '1,0 2x4' },
    { 'f', '3,0 1x4' },
    { 'x', '0,2 1x2' },
    { 'c', '1,2 2x2' },
    { 'v', '3,2 1x2' },
}

for i, binding in ipairs(hyperGridHotkeys) do
    local key = binding[1]
    local pos = binding[2]
    local launcher = function()
        local win = hs.window.focusedWindow()
        hs.grid.set(win, pos)
    end
    hyperBind(key, launcher)
end

hs.hotkey.bind(meh, 'z', function ()
    hs.grid.show()
end)

hs.hotkey.bind(meh, 'h', function ()
    hs.hints.windowHints()
end)

hs.alert.show('conf reloaded')
