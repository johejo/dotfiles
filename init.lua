vim.cmd("packadd vim-jetpack")

require("jetpack").setup({
  { "tani/vim-jetpack", opt = 1 },
  "neovim/nvim-lspconfig",
  "b0o/schemastore.nvim",
  "nvim-lua/plenary.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "hrsh7th/nvim-pasta",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-calc",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "octaltree/cmp-look",
  "ray-x/cmp-treesitter",
  "dmitmel/cmp-cmdline-history",
  "meetcw/cmp-browser-source",
  "hrsh7th/nvim-cmp",
  "nvim-treesitter/nvim-treesitter",
  "cohama/lexima.vim",
  "kana/vim-submode",
  "vijaymarupudi/nvim-fzf",
  "ibhagwan/fzf-lua",
  "kyazdani42/nvim-web-devicons",
  "lambdalisue/fern.vim",
  "lambdalisue/fern-git-status.vim",
  "lambdalisue/fern-hijack.vim",
  "lambdalisue/nerdfont.vim",
  "lambdalisue/fern-renderer-nerdfont.vim",
  "lambdalisue/glyph-palette.vim",
  "zdharma-continuum/zinit-vim-syntax",
  "srcery-colors/srcery-vim",
  { "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  "junegunn/fzf",
})

vim.opt.swapfile = false
vim.opt.number = true
vim.opt.updatetime = 250
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = "tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%"
vim.cmd("colorscheme srcery")

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "go",
    "gomod",
    "dockerfile",
    "bash",
    "cmake",
    "comment",
    "vim",
    "hcl",
    "html",
    "json",
    "make",
    "php",
    "proto",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "javascript",
    "jsdoc",
    "yaml",
    "python",
    "zig",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

require("cmp-browser-source").start_server()

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "vsnip" },
    { name = "calc" },
    { name = "nvim_lsp_signature_help" },
    { name = "browser" },
    { name = "look", keyword_length = 2, convert_case = true, loud = true },
  }),
})
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
    { name = "nvim_lsp_document_symbol" },
  }),
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
    { name = "cmdline_history" },
  }),
})

local schemastore = require("schemastore")

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      autostart = true,
    }),
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.cppcheck,
  },
  on_attach = function()
    vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, { buffer = true })
  end,
})

local language_servers = {
  gopls = {
    formatting_fn = function()
      vim.lsp.buf.format({ async = false })
      local params = vim.lsp.util.make_range_params()
      params.context = { only = { "source.organizeImports" } }
      local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
      for _, res in pairs(results or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
          elseif r.command then
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end,
  },
  tsserver = {
    disable_format = true,
  },
  eslint = {},
  jsonls = {
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
      },
    },
  },
  cssls = {},
  vimls = {},
  yamlls = {},
  pyright = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
    disable_format = true,
  },
  clangd = {
    disable_format = true,
    capabilities_fn = function(capabilities)
      capabilities.offsetEncoding = { "utf-8" }
      return capabilities
    end,
  },
  terraformls = {},
  bashls = {},
  dockerls = {},
  marksman = {},
  zls = {},
}

local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
cmp_capabilities.textDocument.completion.completionItem.snippetSupport = true

for server, opts in pairs(language_servers) do
  local capabilities = opts.capabilities_fn and opts.capabilities_fn(cmp_capabilities) or cmp_capabilities
  require("lspconfig")[server].setup({
    capabilities = capabilities,
    settings = opts.settings,
    on_attach = function(client)
      local map_opts = { buffer = true }
      vim.keymap.set("n", "H", vim.lsp.buf.hover, map_opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, map_opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, map_opts)
      vim.keymap.set("n", "<C-q>", vim.lsp.buf.references, map_opts)
      vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, map_opts)
      if opts.disable_format then
        client.server_capabilities.document_formatting = false
        client.server_capabilities.documentFormattingProvider = false
      else
        if opts.formatting_fn then
          vim.keymap.set("n", "<C-f>", opts.formatting_fn, map_opts)
        else
          vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, map_opts)
        end
      end
    end,
  })
end

vim.keymap.set("n", "<C-d>", vim.diagnostic.open_float)
vim.diagnostic.config({ virtual_text = false, update_in_insert = true })

require("indent_blankline").setup({
  show_end_of_line = true,
  show_current_context = true,
})

local fzf_lua = require("fzf-lua")
vim.keymap.set("n", "..", fzf_lua.files)
vim.keymap.set("n", "<Space>g", fzf_lua.live_grep)
vim.keymap.set("n", "<C-p>", fzf_lua.oldfiles)

vim.keymap.set({ "n", "v" }, "<C-e>", "5<C-e>")
vim.keymap.set({ "n", "v" }, "<C-y>", "5<C-y>")
vim.keymap.set({ "n", "v" }, "<C-h>", "0")
vim.keymap.set({ "n", "v" }, "<C-j>", "5j")
vim.keymap.set({ "n", "v" }, "<C-k>", "5k")
vim.keymap.set({ "n", "v" }, "<C-l>", "$")
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.cmd([[
  call submode#enter_with('winsize', 'n', '', '<C-w><C-l>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><C-h>', '<C-w><')
  call submode#enter_with('winsize', 'n', '', '<C-w><C-k>', '<C-w>+')
  call submode#enter_with('winsize', 'n', '', '<C-w><C-j>', '<C-w>-')
  call submode#map('winsize', 'n', '', '<C-l>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<C-h>', '<C-w><')
  call submode#map('winsize', 'n', '', '<C-k>', '<C-w>+')
  call submode#map('winsize', 'n', '', '<C-j>', '<C-w>-')
  let g:fern#renderer = "nerdfont"

  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END

  highlight Visual guibg=#839496 gui=None guifg=#002b36
]])

vim.keymap.set({ "n", "x" }, "p", require("pasta.mappings").p)
vim.keymap.set({ "n", "x" }, "P", require("pasta.mappings").P)

vim.keymap.set("n", "<Space>f", "<cmd>Fern . -keep -toggle -drawer<CR>")
