-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- Trigger existing hyper key shortcuts

-- k:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)

launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

-- Single keybinding for app launch
singleapps = {
  {'a', 'Google Chrome'},
  {'s', 'iTerm2'},
  {'d', 'MacVim'},
  {'c', 'Slack'},
  {'f', 'Google Play Music Desktop Player'}
}

for i, app in ipairs(singleapps) do
  k:bind({}, app[1], function() launch(app[2]); k:exit(); end)
end

-- Sequential keybindings, e.g. Hyper-a,f for Finder
--a = hs.hotkey.modal.new({}, "F16")]]
--apps = {}
--for i, app in ipairs(apps) do
--  a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
--end

--pressedA = function() a:enter() end
--releasedA = function() end
--k:bind({}, 'a', nil, pressedA, releasedA)

-- Shortcut to reload config

ofun = function()
  hs.reload()
  hs.alert.show('Config reloaded')
  k.triggered = true
end
k:bind({}, 'r', nil, ofun)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

