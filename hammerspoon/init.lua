local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}

local appHotkeys = {
    { 'u', 'FirefoxDeveloperEdition' },
    { '8', 'Safari' },
    { '7', 'Google Chrome' },
    { 'i', 'Sublime Text'},
    --{ 'i', 'Emacs' },
    --{ 'i', 'Atom' },
    --{ 'i', 'PhpStorm' },
    --{ 'i', 'MacVim' },
    { 'o', 'iTerm' },
    { 'y', 'Slack' },
    { 'p', 'Google Play Music Desktop Player' },
}

local hyperMap = hs.hotkey.modal.new()

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

hs.hotkey.bind({}, 'F12', function ()
    hs.caffeinate.lockScreen()
end)

hs.hotkey.bind({}, 'F13', function ()
    hs.reload()
end)

hs.alert.show('conf reloaded')
