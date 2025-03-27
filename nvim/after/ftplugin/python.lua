local project_root = vim.fs.root(0, {'pyproject.toml', 'requirements.txt'})

if project_root == nil then
  vim.lsp.start({
    name = 'python-lsp-server',
    cmd = {'pylsp'},
    root_dir = ".",
  })
else
  vim.lsp.start({
    name = 'python-lsp-server',
    cmd = {'pylsp'},
    cmd_env = { VIRTUAL_ENV = project_root .. "/.venv" },
    root_dir = project_root,
  })
end


vim.opt_local.expandtab = true -- replace tabs with spaces
vim.opt_local.tabstop = 4 -- number of spaces to use
vim.opt_local.shiftwidth = 4 -- number of spaces used for indentation
vim.opt_local.softtabstop = 4 -- backspace treats 4 spaces as a tab
vim.opt_local.autoindent = true

-- vim.opt_local.formatprg = "ruff check --select I --fix --silent - | ruff format -"
vim.opt_local.formatprg = "ruff format -"

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  buffer = 0,
  callback = function()
    require("lint").try_lint("ruff")
    require("lint").try_lint("mypy")
  end,
})

-- vim.g.python_indent = {}
-- vim.g.python_indent.open_paren = 'shiftwidth()'
-- vim.g.python_indent.nested_paren = 'shiftwidth()'
-- vim.g.python_indent.continue = 'shiftwidth() * 2'
-- vim.g.python_indent.closed_paren_align_last_line = false
