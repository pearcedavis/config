local root_dir = vim.fs.root(0, {'package.json'})
if root_dir == nil then root_dir = "." end

vim.lsp.start({
  name = 'typescript-language-server',
  cmd = {'typescript-language-server', '--stdio'},
  root_dir = root_dir,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  buffer = 0,
  callback = function()
    require("lint").try_lint("eslint", { ignore_errors = true })
  end,
})

local prettier_config_dir = vim.fs.root(0, {'.prettierrc'})
if prettier_config_dir then
  vim.opt_local.formatprg = "prettier --parser espree --config " .. prettier_config_dir .. '/.prettierrc'
else
  vim.opt_local.formatprg = "prettier --parser espree"
end

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.autoindent = true
