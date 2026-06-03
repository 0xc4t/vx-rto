local ok, blink = pcall(require, "blink.cmp")
if not ok then
  vim.notify("blink.cmp not found", vim.log.levels.WARN)
  return
end

-- blink.cmp is configured via the plugin spec opts in plugins.lua
-- This file is kept for any additional blink.cmp customization if needed

-- Note: blink.cmp auto-integrates with LSP. No extra source plugins needed.
