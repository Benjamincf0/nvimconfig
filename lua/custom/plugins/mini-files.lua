local files = require 'mini.files'

files.setup {
  mappings = {
    go_in_plus = '<CR>',
  },
  windows = {
    preview = true,
  },
}

vim.keymap.set('n', '-', function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' or vim.bo.buftype ~= '' then
    path = vim.fn.getcwd()
  elseif not vim.uv.fs_stat(path) then
    path = vim.fs.dirname(path)
    if not vim.uv.fs_stat(path) then path = vim.fn.getcwd() end
  end
  files.open(path, false)
end, { desc = 'Open current file directory' })

vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('custom-mini-files', { clear = true }),
  pattern = 'MiniFilesBufferCreate',
  callback = function(event)
    -- Keep h/l navigation and let - go to the parent, as it did in Oil.
    vim.keymap.set('n', '-', files.go_out, { buffer = event.data.buf_id, desc = 'Go to parent directory' })
  end,
})
