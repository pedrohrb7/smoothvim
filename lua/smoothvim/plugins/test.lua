vim.pack.add({})

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
