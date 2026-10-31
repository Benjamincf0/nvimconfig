vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'strudel.nvim' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      local result = vim.system({ 'npm', 'ci' }, { cwd = ev.data.path }):wait()
      if result.code ~= 0 then error 'strudel.nvim: npm ci failed' end
    end
  end,
})

vim.pack.add { 'https://github.com/gruvw/strudel.nvim' }
local strudel = require 'strudel'
strudel.setup {
  -- Strudel web user interface related options
  ui = {
    -- Maximise the menu panel
    -- (optional, default: true)
    maximise_menu_panel = true,
    -- Hide the Strudel menu panel (and handle)
    -- (optional, default: false)
    hide_menu_panel = false,
    -- Hide the default Strudel top bar (controls)
    -- (optional, default: false)
    hide_top_bar = false,
    -- Hide the Strudel code editor
    -- (optional, default: false)
    hide_code_editor = false,
    -- Hide the Strudel eval error display under the editor
    -- (optional, default: false)
    hide_error_display = false,
  },
  -- Automatically start playback when launching Strudel
  -- (optional, default: true)
  start_on_launch = true,
  -- Set to `true` to automatically trigger the code evaluation after saving the buffer content
  -- Only works if the playback was already started (doesn't start the playback on save)
  -- (optional, default: false)
  update_on_save = true,
  -- Enable two-way cursor position sync between Neovim and Strudel editor
  -- (optional, default: true)
  sync_cursor = true,
  -- Report evaluation errors from Strudel as Neovim notifications
  -- (optional, default: true)
  report_eval_errors = true,
  -- Path to a custom CSS file to style the Strudel web editor (base64-encoded and injected at launch)
  -- This allows you to override or extend the default Strudel UI appearance
  -- (optional, default: nil)
  -- custom_css_file = '/path/to/your/custom.css',
  -- Headless mode: set to `true` to run the browser without launching a window
  -- (optional, default: false)
  headless = false,
  -- Path to the directory where Strudel browser user data (cookies, sessions, etc.) is stored
  -- (optional, default: "~/.cache/strudel-nvim/")
  browser_data_dir = '~/.cache/strudel-nvim/',
  -- Path to a (chromium-based) browser executable of choice
  -- (optional, default: nil)
  browser_exec_path = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
  -- Custom URL for Strudel
  -- (optional, default: "https://cold.strudel.cc/")
  strudel_url = 'https://cold.strudel.cc/',
}

vim.keymap.set('n', '<leader>sl', strudel.launch, { desc = 'Launch Strudel' })
vim.keymap.set('n', '<leader>sq', strudel.quit, { desc = 'Quit Strudel' })
vim.keymap.set('n', '<leader>st', strudel.toggle, { desc = 'Strudel Toggle Play/Stop' })
vim.keymap.set('n', '<leader>su', strudel.update, { desc = 'Strudel Update' })
vim.keymap.set('n', '<leader>ss', strudel.stop, { desc = 'Strudel Stop Playback' })
vim.keymap.set('n', '<leader>sb', strudel.set_buffer, { desc = 'Strudel set current buffer' })
vim.keymap.set('n', '<leader>sx', strudel.execute, { desc = 'Strudel set current buffer and update' })
