local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}

local appHotkeys = {
    { '8', 'Safari' },
    { 'u', 'Google Chrome' },
    { 'i', 'iTerm' },
    { 'o', 'Visual Studio Code' },
    { 'y', 'Slack' },
    { '7', 'Stride' },
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
hs.grid.setGrid('6x6')

mehBind('a', function ()
    local win = hs.window.focusedWindow()
    win:moveOneScreenWest()
end)

mehBind('g', function ()
    local win = hs.window.focusedWindow()
    win:moveOneScreenEast()
end)

local mehGridHotkeys = {
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
    { 'w', '0,0 2x3' },
    { 'e', '2,0 2x3' },
    { 'r', '4,0 2x3' },
    { 's', '0,0 2x6' },
    { 'd', '2,0 2x6' },
    { 'f', '4,0 2x6' },
    { 'x', '0,3 2x3' },
    { 'c', '2,3 2x3' },
    { 'v', '4,3 2x3' },
    { 'g', '2,0 4x6' },
    { 'a', '0,0 4x6' },
    { 'q', '0,0 1x2' },
    { 't', '5,0 1x2' },
    { 'z', '0,4 1x2' },
    { 'b', '5,4 1x2' },
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

hs.hints.hintChars = { 'j', 'k', 'l', 'h', 's', 'd', 'f', 'g' }

hs.hotkey.bind(meh, 'k', function ()
    hs.hints.windowHints()
end)

hs.alert.show('conf reloaded')
