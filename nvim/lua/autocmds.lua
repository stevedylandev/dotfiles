vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
        if vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
        end
    end
})

-- Reload files automatically if edited externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv(0) == "" then
      vim.schedule(function()
        require("mini.pick").builtin.files()
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mdx", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true  -- Break at word boundaries
    vim.opt_local.spell = true
  end,
})
