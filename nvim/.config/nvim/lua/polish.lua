-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- Trigger checktime in various events to detect external changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "checktime",
})
-- Another option to create a function that you can call to manually watch a particular file.
-- TBD if it can be configured to automatically watch every opened file, and whether the
-- watches are shutdown nicely.
-- https://neovim.io/doc/user/lua.html#watch-file

-- Custom :DiffOrig command to compare the current modified buffer
-- with the behind-the-scenes edits saved to disk.
-- https://neovim.io/doc/user/diff.html#%3ADiffOrig
vim.api.nvim_create_user_command("DiffOrig", function()
  vim.cmd "vert new"
  vim.bo.buftype = "nofile"
  vim.cmd "read ++edit #"
  vim.cmd "0d_"
  vim.cmd "diffthis"
  vim.cmd "wincmd p"
  vim.cmd "diffthis"
end, {})

-- Custom :SaveBackupAndReload command to save the current modified buffer
-- to backup file before reloading disk version
vim.api.nvim_create_user_command("SaveBackupAndReload", function()
  local backup_name = vim.fn.expand "%" .. ".backup." .. os.date "%Y%m%d_%H%M%S"
  vim.cmd("write " .. backup_name)
  vim.notify("Saved backup to: " .. backup_name, vim.log.levels.INFO)
  vim.cmd "edit!"
end, {})
