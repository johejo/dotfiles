vim.cmd("packadd vim-jetpack")

require("jetpack.packer").add({
	{ "tani/vim-jetpack" },
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	{ "neovim/nvim-lspconfig" },
	{ "stevearc/dressing.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "ibhagwan/fzf-lua" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },
	{ "octaltree/cmp-look" },
	{ "b0o/schemastore.nvim" },
	{ "windwp/nvim-autopairs" },
	--	{ "zbirenbaum/copilot.lua" },
	--	{ "zbirenbaum/copilot-cmp" },
	{ "projekt0n/github-nvim-theme" },
	{ "sainnhe/gruvbox-material" },
	{ "lukas-reineke/cmp-rg" },
	{ "bydlw98/cmp-env" },
	{ "lambdalisue/fern.vim" },
	{ "lambdalisue/fern-git-status.vim" },
	{ "lambdalisue/fern-hijack.vim" },
	{ "lambdalisue/nerdfont.vim" },
	{ "lambdalisue/fern-renderer-nerdfont.vim" },
	{ "lambdalisue/glyph-palette.vim" },
})

vim.g.everforest_background = "soft"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "hard"
vim.cmd.colorscheme("gruvbox-material")

--require("copilot").setup({
--	suggestion = { enabled = false },
--	panel = { enabled = false },
--})

--require("copilot_cmp").setup()

local autopairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
autopairs.setup({
	check_ts = true,
})

local fzf_lua = require("fzf-lua")
vim.keymap.set("n", "..", fzf_lua.files)
vim.keymap.set("n", "<Space>g", fzf_lua.live_grep_resume)
vim.keymap.set("n", "<C-p>", fzf_lua.oldfiles)
vim.keymap.set("n", "<C-b>", fzf_lua.buffers)

local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				buffer = "[buffer]",
				nvim_lsp = "[LSP]",
				vsnip = "[vsnip]",
				path = "[path]",
				look = "[look]",
				--copilot = "[copilot]",
				rg = "[rg]",
				env = "[env]",
			})[entry.source.name]
			return vim_item
		end,
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "look" },
		--		{ name = "copilot" },
		{ name = "rg" },
		{ name = "env" },
	}),
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
	}),
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"go",
		"typescript",
		"vim",
		"json",
		"dockerfile",
		"terraform",
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

local lspconfig = require("lspconfig")
local runtime_path = vim.split(package.path, ";")
lspconfig.gopls.setup({
	capabilities = capabilities,
	settings = {
		gopls = {
			staticcheck = true,
		},
	},
})
lspconfig.vtsls.setup({
	capabilities = capabilities,
	init_options = { documentFormatting = false },
})
lspconfig.eslint.setup({
	capabilities = capabilities,
})
lspconfig.jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
lspconfig.yamlls.setup({
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})
lspconfig.dockerls.setup({
	capabilities = capabilities,
})
lspconfig.terraformls.setup({
	capabilities = capabilities,
})

local prettier = {
	formatCommand = "npx --no -- prettier --stdin --stdin-filepath ${INPUT} ${--range-start:charStart} ${--range-end:charEnd}",
	formatStdin = true,
	formatCanRange = true,
	rootMarkers = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.mjs",
		".prettierrc.cjs",
		".prettierrc.toml",
	},
}
local stylua = {
	formatCommand = "stylua ${--indent-width:tabSize} ${--range-start:charStart} ${--range-end:charEnd} --color Never -",
	formatStdin = true,
	formatCanRange = true,
	rootMarkers = { "stylua.toml", ".stylua.toml" },
}
local shfmt = {
	formatCommand = "shfmt -filename ${INPUT} -",
	formatStdin = true,
}
local shellcheck = {
	lintCommand = "shellcheck --color=never --format=gcc -",
	lintStdin = true,
	lintFormats = { "-:%l:%c: %trror: %m", "-:%l:%c: %tarning: %m", "-:%l:%c: %tote: %m" },
	rootMarkers = { ".shellcheckrc" },
}
local yamlfmt = {
	formatCommand = "yamlfmt -in",
	formatStdin = true,
}
local hadolint = {
	lintCommand = "hadolint --no-color -",
	lintStdin = true,
	lintFormats = { "-:%l %.%# %trror: %m", "-:%l %.%# %tarning: %m", "-:%l %.%# %tnfo: %m" },
	rootMarkers = { ".hadolint.yaml" },
}
lspconfig.efm.setup({
	init_options = { documentFormatting = true },
	filetypes = {
		"typescript",
		"typescriptreact",
		"lua",
		"zsh",
		"sh",
		"bash",
		"yaml",
		"dockerfile",
	},
	capabilities = capabilities,
	settings = {
		languages = {
			typescript = { prettier },
			typescriptreact = { prettier },
			lua = { stylua },
			zsh = { shfmt, shellcheck },
			sh = { shfmt, shellcheck },
			bash = { shfmt, shellcheck },
			yaml = { yamlfmt },
			dockerfile = { hadolint },
		},
	},
})
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			format = { enable = false },
			telemetry = {
				enable = false,
			},
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostic = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file("", true),
				},
			},
		},
	},
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<C-i>", function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { "source.organizeImports" },
				},
			})
		end, opts)
		vim.keymap.set("n", "<C-q>", fzf_lua.lsp_references, opts)
	end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("UserGoConfig", {}),
	pattern = { "go", "caddyfile", "lua" },
	callback = function()
		vim.opt_local.expandtab = false
	end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("UserGHAConfig", {}),
	pattern = { "*/.github/workflows/*.y{a,}ml" },
	callback = function()
		vim.cmd([[syn region GhaDollarSyntax matchgroup=PreProc start="${{" end="}}" containedin=yamlPlainScalar]])
	end,
})

vim.opt.updatetime = 250
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.listchars = {
	tab = "▸ ",
	trail = "·",
	nbsp = "␣",
	extends = ">",
	precedes = "<",
}

vim.keymap.set({ "n", "v" }, "<C-e>", "5<C-e>")
vim.keymap.set({ "n", "v" }, "<C-y>", "5<C-y>")
vim.keymap.set({ "n", "v" }, "<C-h>", "0")
vim.keymap.set({ "n", "v" }, "<C-j>", "5j")
vim.keymap.set({ "n", "v" }, "<C-k>", "5k")
vim.keymap.set({ "n", "v" }, "<C-l>", "$")
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set("n", "<C-d>", vim.diagnostic.open_float)
vim.diagnostic.config({
	update_in_insert = true,
	virtual_text = false,
})

require("dressing").setup({})

vim.g["fern#renderer"] = "nerdfont"

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("UserFernConfig", {}),
	pattern = { "fern" },
	callback = function()
		vim.fn["glyph_palette#apply"]()
		vim.cmd([[highlight Visual guibg=#839496 gui=None guifg=#002b36]])
	end,
})
