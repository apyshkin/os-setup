return {
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
    cmd = {
      "CMakeGenerate",
      "CMakeBuild",
      "CMakeRun",
      "CMakeClean",
      "CMakeStopExecutor",
      "CMakeStopRunner",
      "CMakeSelectBuildTarget",
      "CMakeSelectLaunchTarget",
      "CMakeSelectBuildType",
      "CMakeSelectKit",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local base = {
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_generate_options = {
          "-G",
          "Ninja Multi-Config",
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
        },
        cmake_soft_link_compile_commands = true,
        cmake_compile_commands_from_lsp = false,
        cmake_regenerate_on_save = false,
        cmake_executor = {
          name = "terminal",
          opts = {
            name = "CMake Build",
            prefix_name = "[CMake]: ",
            split_direction = "horizontal",
            split_size = 15,
            single_terminal = true,
            keep_terminal_static_location = true,
            start_insert = false,
            focus = false,
            do_not_add_newline = false,
          },
        },
        cmake_runner = {
          name = "terminal",
          opts = {},
        },
        cmake_notifications = {
          runner = { enabled = true },
          executor = { enabled = true },
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          refresh_rate_ms = 100,
        },
      }
      if type(vim.g.cmake_project_overrides) == "table" then
        return vim.tbl_deep_extend("force", base, vim.g.cmake_project_overrides)
      end
      return base
    end,
  },
}
