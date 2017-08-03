local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}

local appHotkeys = {
    { 'u', 'Google Chrome' },
    { 'i', 'Emacs' },
    --{ 'i', 'Atom' },
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

hyperBind('=', function ()
    hs.caffeinate.lockScreen()
end)

hyperBind('`', function ()
    hs.reload()
end)

pressedF19 = function()
  hyperMap.triggered = false
  hyperMap:enter()
end

releasedF19 = function()
  hyperMap:exit()
  if not hyperMap.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

f19 = hs.hotkey.bind({}, 'F19', pressedF19, releasedF19)

hs.alert.show('conf reloaded')
