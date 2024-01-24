vim.keymap.set(
  { "n", "v" },
  "<leader>as",
  ":<c-u>lua require('ollama').prompt('Simplify_Code')<cr>",
  { desc = "Simplify", noremap = true }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>aq",
  ":<c-u>lua require('ollama').prompt('Ask_About_Code')<cr>",
  { desc = "Question", noremap = true }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>ag",
  ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
  { desc = "Generate", noremap = true }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>ae",
  ":<c-u>lua require('ollama').prompt('Explain_Code')<cr>",
  { desc = "Explain", noremap = true }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>ac",
  ":<c-u>lua require('ollama').prompt('Add_Comments')<cr>",
  { desc = "Add Comments", noremap = true }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>as",
  ":<c-u>lua require('ollama').prompt('Safer_Code')<cr>",
  { desc = "Make code safer", noremap = true }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>af",
  ":<c-u>lua require('ollama').prompt('Finish_Code')<cr>",
  { desc = "Finish code outline", noremap = true }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>at",
  ":<c-u>lua require('ollama').prompt('Type_Hint_Code')<cr>",
  { desc = "Finish code outline", noremap = true }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>am",
  ":<c-u>lua require('ollama').prompt('Modify_Code')<cr>",
  { desc = "Modify with custom prompt", noremap = true }
)

local response_format = "Respond EXACTLY in this format:\n```$ftype\n<your code>\n```"

return {
  "nomnivore/ollama.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    model = "local",
    url = "http://127.0.0.1:11434",
    serve = {
      on_start = false,
      command = "ollama",
      args = { "serve" },
      stop_command = "pkill",
      stop_args = { "-SIGTERM", "ollama" },
    },
    prompts = {
      Add_Comments = {
        prompt = "Add comments to the following $ftype code, and clarify existing comments "
          .. response_format
          .. "\n\n```$ftype\n$sel```",
        action = "replace",
      },
      Safer_Code = {
        prompt = "Make the following $ftype code safer by using industry best practices."
          .. response_format
          .. "\n\n```$ftype\n$sel```",
        action = "replace",
      },
      Type_Hint_Code = {
        prompt = "Add types to the following $ftype code" .. response_format .. "\n\n```$ftype\n$sel```",
        action = "replace",
      },
      Finish_Code = {
        prompt = "Finish the following $ftype code using industry best practices. Include plenty of comments explaining your thought process, and how you're making this code safe and following best practices."
          .. response_format
          .. "\n\n```$ftype\n$sel```",
        action = "replace",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,

    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          local status = require("ollama").status()

          if status == "IDLE" then
            return "󱙺" -- nf-md-robot-outline
          elseif status == "WORKING" then
            return "󰚩" -- nf-md-robot
          end
        end,
        cond = function()
          return package.loaded["ollama"] and require("ollama").status() ~= nil
        end,
      })
    end,
  },
}
