local get_hex = require('cokeline/utils').get_hex
local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3
local green = vim.g.terminal_color_2


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
      text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
    },
    {
      text = '  ',
    },
    {
      text = function(buffer)
        return
          (is_picking_focus() or is_picking_close())
          and buffer.pick_letter .. ' '
           or buffer.devicon.icon
      end,
      fg = function(buffer)
        return
          (is_picking_focus() and yellow)
          or (is_picking_close() and red)
          or buffer.devicon.color
      end,
      style = function(_)
        return
          (is_picking_focus() or is_picking_close())
          and 'italic,bold'
           or nil
      end,
    },
    {
      text = ' ',
    },
    {
      text = function(buffer) return buffer.filename .. '  ' end,
      style = function(buffer) return buffer.is_focused and 'bold' or nil end,
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = '  ',
    },
  },

})
