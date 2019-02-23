local naughty = require("naughty")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local table = require("table")
local state = {
    messages = {},
    counter = 1
}

function state:reset()
    self.messages = {}
    self.counter = 1
end

local notfications_widget = wibox.widget {
    text = "",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local list_panel = wibox {
    height = 200,
    width = 400,
    ontop = true,
    bg = beautiful.bg_normal,
    border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    max_widget_size = 500
}

function notfications_widget:update_graphic()
    count = #state.messages
    if count == 0 then
        self.text = ""
        list_panel.visible = false
    else
        self.text = " Messages: " .. tostring(count) .. " "
    end
end

function notfications_widget:new_message(message)
    table.insert(state.messages, "<b>" .. message.title .. ":</b> " .. message.text)
    self:update_graphic()
    list_panel:update_graphic()
end

list_panel:setup {
    markup = "",
    valign = "top",
    wrap = 'word',
    forced_width = 25,
    id = 'textbox',
    widget = wibox.widget.textbox
}

function list_panel:update_graphic()
    awful.placement.top_right(self, { margins = {top = 25, right = 10}})
    local text = ""
    for i=state.counter, #state.messages, 1 do
        text = text .. state.messages[i] .. "\n"
    end
    self.textbox.markup = text
end

function on_button_press(button)
    if button == 3 then
        state:reset()
        notfications_widget:update_graphic()
    elseif button == 1 then
        list_panel.visible = not list_panel.visible
        if list_panel.visible then
            list_panel.screen = awful.screen.focused()
        end
        list_panel:update_graphic()
    elseif button == 5 and state.counter < #state.messages then
        state.counter = state.counter + 1
        list_panel:update_graphic()
    elseif button == 4 and state.counter > 1 then
        state.counter = state.counter - 1
        list_panel:update_graphic()
    end
end

list_panel:connect_signal("button::press", function(_,_,_,button)
    on_button_press(button)
end)

notfications_widget:connect_signal("button::press", function(_,_,_,button)
    on_button_press(button)
end)


notfications_widget:update_graphic()
return notfications_widget
