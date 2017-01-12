local hyper = {'shift', 'cmd', 'alt', 'ctrl'}
local meh = {'cmd', 'alt', 'ctrl'}
hs.hotkey.bind(hyper, '1', function ()
    hs.application.launchOrFocus('Google Chrome')
end)

hs.hotkey.bind(hyper, '2', function ()
    hs.application.launchOrFocus('iTerm')
end)

hs.hotkey.bind(hyper, '3', function ()
    hs.application.launchOrFocus('MacVim')
end)

hs.hotkey.bind(hyper, '4', function ()
    hs.application.launchOrFocus('Slack')
end)

hs.hotkey.bind(hyper, '5', function ()
    hs.application.launchOrFocus('Google Play Music Desktop Player')
end)

hs.hotkey.bind(hyper, ';', function ()
    hs.caffeinate.lockScreen()
end)

hs.hotkey.bind(hyper, '`', function ()
    hs.reload()
end)

hs.alert.show('conf reloaded')
