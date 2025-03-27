vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = event.buf}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can find details of these function in the help page
    -- see for example, :help vim.lsp.buf.hover()

    -- Jump to the definition
    bufmap('n', 'gt', '<cmd>lua vim.lsp.buf.definition()<cr>')

  end
})

vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
  if not (result and result.contents) then
    print('No information available')
    return
  end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  if vim.tbl_isempty(markdown_lines) then
    print('No information available')
    return
  end
  local buf = vim.fn.bufnr("hover-info")
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, true)
    local buf_opts = { buf = buf }
	  vim.api.nvim_buf_set_name(buf, "hover-info")
    vim.api.nvim_set_option_value("bufhidden", "wipe", buf_opts)
    vim.api.nvim_set_option_value("filetype", "markdown", buf_opts)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, markdown_lines)
    vim.api.nvim_set_option_value("readonly", true, buf_opts)
    vim.api.nvim_command("split")
    vim.api.nvim_set_current_buf(buf)
  else
    local buf_opts = { buf = buf }
    vim.api.nvim_set_option_value("readonly", false, buf_opts)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, markdown_lines)
    vim.api.nvim_set_option_value("readonly", true, buf_opts)
  end
end

vim.cmd.colorscheme("monokai")

vim.g.mapleader = " "
local keymap_opts = { noremap = true }
vim.keymap.set("n", "<Leader>j", ":bp<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>k", ":bn<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>l", "<C-W><C-W>", keymap_opts)
-- vim.keymap.set("n", "<Leader>h", ":noh<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>h", ":set hlsearch!<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>c", ":set cuc!<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>v", ":vsplit<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>w", ":w<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>q", ":q<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>x", ":bp<bar>bd#<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>e", ":CtrlPMixed<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>b", ":CtrlPBuffer<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>ff", "gggqG", keymap_opts)
-- vim.keymap.set("n", "<Leader>b", ":ls<CR>:b<Space>", keymap_opts)
vim.keymap.set("n", "<Leader>gs", ":Git<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>gd", ":Gdiffsplit<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>r", ":redraw!<CR>", keymap_opts)
vim.keymap.set("n", "<Leader>t", ":NERDTreeToggle<CR>", keymap_opts)
vim.keymap.set("i", "<C-L>", "<C-X><C-L>", keymap_opts)
vim.keymap.set("i", "<C-O>", "<C-X><C-O>", keymap_opts)
vim.keymap.set("n", "qq", "<NOP>", keymap_opts)
-- centre search results
vim.keymap.set("n", "n", "nzz", keymap_opts)
vim.keymap.set("n", "N", "Nzz", keymap_opts)
vim.keymap.set("n", "*", "*zz", keymap_opts)
-- paste over selection without yanking
vim.keymap.set("v", "p", "\"_dP", keymap_opts)
vim.keymap.set("v", "c", "\"_c", keymap_opts)
vim.keymap.set("n", "c", "\"_c", keymap_opts)
-- clipboard copy and paste
vim.keymap.set("v", "<C-C>", "\"*y", keymap_opts)
vim.keymap.set("n", "<C-V>", "\"*p", keymap_opts)
-- vim.keymap.set("v", "<C-C>", ":w !xsel -i -b<CR><CR>", keymap_opts)
-- vim.keymap.set("n", "<C-V>", ":r !xsel -o -b<CR>", keymap_opts)
-- vim.keymap.set("v", "<C-C>", ":w !wl-copy <CR><CR>", keymap_opts)
-- vim.keymap.set("n", "<C-V>", ":r !wl-paste<CR>", keymap_opts)
-- vim.keymap.set("v", "<C-C>", ":w !pbcopy <CR><CR>", keymap_opts)
-- vim.keymap.set("n", "<C-V>", ":r !pbpaste<CR>", keymap_opts)

vim.opt.completeopt:append("noselect")
vim.opt.runtimepath:append("/opt/homebrew/opt/fzf")

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

vim.diagnostic.config({
signs = {
    text = {
	[vim.diagnostic.severity.ERROR] = '',
	[vim.diagnostic.severity.WARN] = '',
	[vim.diagnostic.severity.INFO] = '',
	[vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
	[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
	[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
	[vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
	[vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
},
})

vim.opt.spell = true
vim.opt.spelllang = "en_gb"

vim.g.ctrlp_user_command = {'.git', 'cd %s && git ls-files --cached --others --exclude-standard'}
vim.g.ctrlp_use_caching = 0
vim.g.ctrlp_mruf_exclude = '.git/COMMIT_EDITMSG'
vim.g.ctrlp_match_current_file = 1
vim.g.ctrlp_mruf_relative = 1

vim.g.netrw_altv = 1

local git_root = vim.fs.root(0, {'.git'})
if git_root then
  vim.opt.grepprg="git grep -n --column"
  vim.opt.grepformat="%f:%l:%c:%m"
end

vim.api.nvim_command("command! -nargs=+ -complete=file Grep execute 'silent grep! <args>' | cwindow | redraw!")
vim.keymap.set("n", "\\", ":Grep ")

vim.api.nvim_command("command! -bar -range=% StripTrailingWhitespace keeppatterns <line1>,<line2>substitute/\\s\\+$//e")

-- binding to search files for word under cursor (also sets the buffer
-- search to that word for highlighting)
-- vim.keymap.set("n", "<Leader>ss", "/\\<<C-R><C-W>\\><CR><C-O>:Grep -w -F \"<C-R><C-W>\" <CR>")
vim.keymap.set("n", "<Leader>ss", ":Grep -w -F \"<C-R><C-W>\" <CR>")
