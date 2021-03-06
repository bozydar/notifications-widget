# Notifications widget

Collects notifications shown by `naughty`.

![demo](demo.png)

## Features

* Shows the number of already collected in the top.
* Clicking the left button shows/hides a widget with titles and messages
* Clicking the right button resets the state. (Mark as read?)
* Mouse wheel - scrolls messages.

## Installation

1. Clone the library (e.g. in the config directory `~/.config/awesome/`)
   ```
   $ cd ~/.config/awesome/
   $ git clone git@github.com:bozydar/notifications-widget.git
   ```
2. Edit the `rc.lua`
    1. Load the library `local notifications_widget = require('notifications-widget.widget')`
    2. Connect to the `naughty` callback
       ```lua
       naughty.config.notify_callback = function(args)
          notifications_widget:new_message(args)
          return args
       end
       ```
    3. Add the widget to the wibox
       ```
       -- Add widgets to the wibox
       s.mywibox:setup {
           layout = wibox.layout.align.horizontal,
           -- ...
           s.mytasklist, -- Middle widget
           { -- Right widgets
               layout = wibox.layout.fixed.horizontal,
               notifications_widget,  -- <-- for example put it there
               wibox.widget.systray(),
               mytextclock,
           },
       }

3. To test, send a message from the terminal
   ```
   $ notify-send "Title" "Something not really <i>interesting</i> message"
   ```

## TODO

1. Show messages on the same screen as mouse - DONE
2. Remove messages after clicking on the widget - DONE
3. Show title in the box - DONE
4. Indicate that there is more messages there
5. Show icons
