require'nvim_lsp'.gopls.setup{}
require'nvim_lsp'.dockerls.setup{}
require'nvim_lsp'.bashls.setup{}
require'nvim_lsp'.pyls.setup{}
require'nvim_lsp'.tsserver.setup{}

local nvim_lsp = require'nvim_lsp'
local configs = require'nvim_lsp/skeleton'

nvim_lsp.sumneko_lua.setup{
  cmd = {'~/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server', '-E', '~/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua'};
}

-- vim-language-server
if not nvim_lsp.vimls then
  configs.vimls = {
    default_config = {
      cmd = {'vim-language-server', '--stdio'};
      filetypes = {'vim'};
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      log_level = vim.lsp.protocol.MessageType.Warning;
      settings = {};
    };
  }
end
nvim_lsp.vimls.setup{}
