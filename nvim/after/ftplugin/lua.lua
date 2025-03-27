vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.autoindent = true

local path = vim.api.nvim_buf_get_name(0)
if string.find(path, ".config/nvim") ~= nil then
  vim.opt.keywordprg = ":help"
end
