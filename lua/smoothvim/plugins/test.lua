vim.pack.add({
  { src = "https://github.com/nvim-neotest/neotest" },
  { src = "https://github.com/nvim-neotest/neotest-jest" },
  { src = "https://github.com/marilari88/neotest-vitest" },
  { src = "https://github.com/thenbe/neotest-playwright" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
})

require("neotest").setup({
  settings = {
    watch = true,
  },
  adapters = {
    require("neotest-vitest"),
    require("neotest-playwright").adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,
      },
    }),
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestArguments = function(defaultArguments)
        return defaultArguments
      end,
      jestConfigFile = "jest.config.ts",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
      isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
    }),
  },
})
