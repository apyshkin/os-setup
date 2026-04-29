-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff current file" })

local function cmake_select_and_build()
  local cmake = require("cmake-tools")
  cmake.select_build_target(false, function(result)
    if result and result:is_ok() then
      vim.cmd("CMakeBuild")
    end
  end)
end

local function cmake_select_and_run()
  local cmake = require("cmake-tools")
  cmake.select_launch_target(false, function(result)
    if result and result:is_ok() then
      vim.cmd("CMakeRun")
    end
  end)
end

local function cmake_generate_with_args()
  vim.ui.input({ prompt = "CMake extra args: " }, function(extra)
    if extra == nil then
      return
    end
    vim.cmd("CMakeGenerate " .. extra)
  end)
end

vim.keymap.set("n", "<leader>mb", cmake_select_and_build, { desc = "CMake: select target & build" })
vim.keymap.set("n", "<leader>mB", "<cmd>CMakeBuild<cr>", { desc = "CMake: build (no picker)" })
vim.keymap.set("n", "<leader>mg", cmake_generate_with_args, { desc = "CMake: generate (extra args)" })
vim.keymap.set("n", "<leader>mt", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake: select build target" })
vim.keymap.set("n", "<leader>mr", cmake_select_and_run, { desc = "CMake: select & run" })
vim.keymap.set("n", "<leader>mc", "<cmd>CMakeClean<cr>", { desc = "CMake: clean" })
vim.keymap.set("n", "<leader>ms", "<cmd>CMakeStopExecutor<cr>", { desc = "CMake: stop build" })
vim.keymap.set("n", "<leader>my", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake: select build type" })
vim.keymap.set("n", "<leader>mo", "<cmd>CMakeOpenExecutor<cr>", { desc = "CMake: open build output" })
vim.keymap.set("n", "<leader>m?", function()
  local c = require("cmake-tools")
  vim.notify(
    ("target = %s\ntype = %s\nconfigure preset = %s\nbuild preset = %s"):format(
      vim.inspect(c.get_build_target()),
      tostring(c.get_build_type()),
      tostring(c.get_configure_preset()),
      tostring(c.get_build_preset())
    ),
    vim.log.levels.INFO,
    { title = "CMake status" }
  )
end, { desc = "CMake: status" })

vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch source/header" })
