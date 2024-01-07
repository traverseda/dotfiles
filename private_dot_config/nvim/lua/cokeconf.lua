local get_hex = require("cokeline.hlgroups").get_hl_attr
local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3
local green = vim.g.terminal_color_2

--require("cokeline.history"):last():focus()
require("cokeline.history")

require('cokeline').setup({
    show_if_buffers_are_at_least = 2,

    sidebar = {
        filetype = 'neo-tree',
        components = {
        {
            text = "    Files",
            fg = vim.g.terminal_color_2,
            bg = get_hex("NeoTreeNormal", 'bg'),
            style = 'bold'
        }}
    },

  history = {
    enabled = true,
    size = 2
  },

  pick = {
    -- Whether to use the filename's first letter first before
    -- picking a letter from the valid letters list in order.
    -- default: `true`
    use_filename = true,

    -- The list of letters that are valid as pick letters. Sorted by
    -- keyboard reachability by default, but may require tweaking for
    -- non-QWERTY keyboard layouts.
    -- default: asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP'
    letters = 'sdfjkl;ghnmvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP',
  },

  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and green
         or get_hex('Normal', 'fg')
    end,
    bg = get_hex('ColorColumn', 'bg'),
  },

  components = {
    {
      text = '｜',
      fg = function(buffer)
        return
          buffer.is_modified and yellow or green
      end
    },
    {
      text = function(buffer) return buffer.devicon.icon .. ' ' end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.pick_letter end,
      style = function(buffer) return (is_picking_focus() or is_picking_close()) and 'underline,bold' or nil end,
    },
    { text=": " },
    {
      text = function(buffer) return buffer.filename .. ' ' end,
      style = function(buffer) return buffer.is_focused and 'bold' or nil end,
    },
    {
      text = ' ',
    },
  },
})
