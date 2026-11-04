vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

require('oil').setup {
  keymaps = {
    -- Let vim-tmux-navigator handle movement between windows and panes.
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['gR'] = 'actions.refresh',
  },
}

vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Open current file directory' })
