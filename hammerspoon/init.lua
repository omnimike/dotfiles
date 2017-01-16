local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}

local appHotkeys = {
    { 'u', 'Google Chrome' },
    { 'i', 'iTerm' },
    { 'o', 'MacVim' },
    { 'y', 'Slack' },
    { 'p', 'Google Play Music Desktop Player' },
}

local hyperMap = hs.hotkey.modal.new({}, 'F19')

local hyperBind = function(key, fn)
    hs.hotkey.bind(hyper, key, nil, fn)
    hyperMap:bind({}, key, nil, fn)
end

for i, binding in ipairs(appHotkeys) do
    local key = binding[1]
    local app = binding[2]
    local launcher = function()
        hs.application.launchOrFocus(app)
    end
    hyperBind(key, launcher)
end

hyperBind('=', function ()
    hs.caffeinate.lockScreen()
end)

hyperBind('`', function ()
    hs.reload()
end)

hs.alert.show('conf reloaded')
