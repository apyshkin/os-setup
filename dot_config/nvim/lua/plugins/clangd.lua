return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
          cmd = {
            "/usr/bin/clangd-21",
            "--background-index",
            "--background-index-priority=low",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "-j=4",
          },
        },
      },
    },
  },
}
