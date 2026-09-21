vim.pack.add { 'https://github.com/brenoprata10/nvim-highlight-colors' }

vim.opt.termguicolors = true
require('nvim-highlight-colors').setup {
  render = 'background',
  enable_named_colors = true,
  enable_tailwind = true,
}
