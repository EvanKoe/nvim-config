-- Remove trailing space when leaving insert mode
vim.api.nvim_create_autocmd({'BufWrite'}, {
	pattern = '*',
	callback = function ()
		if vim.bo.filetype == 'markdown' or vim.bo.filetype == 'text' then
			return
		end

		local pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd [[ :%s/\s\+$//e ]]
		vim.api.nvim_win_set_cursor(0, pos)
	end
})

-- Prevent auto-opening files like netrw when starting in a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      return
    end

    local file = vim.fn.argv(0)
    if vim.fn.isdirectory(file) == 1 then
      vim.cmd("bd") -- close the buffer
			vim.cmd("Dashboard") -- Opens the dashboard
    end
  end,
})

-- Open all folds on file opened
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = '*',
  command = 'normal zR'
})

-- Remove possibility to fold when opening the Dashboard
vim.api.nvim_create_autocmd('FileType', {
	pattern = { "dashboard", "blink-tree" },
	callback = function ()
		-- vim.opt_local.foldenable = false
		vim.defer_fn(function ()
			vim.opt_local.foldenable = false
		end, 0)
	end
})

-- Start LSP for vue
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vue", "typescript", "javascript", "typescriptreact", "javascriptreact" },
  callback = function()
		require('ekoehler.lsp.vue')
  end
})

-- Make diagnostic window smaller
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'qf',
	callback = function ()
		vim.cmd('resize 3')
		vim.cmd('setlocal winfixheight')
	end
})

-- Close quickfix after item was selected
vim.api.nvim_create_autocmd('BufReadPost', {
	pattern = 'quickfix',
	command = [[ nnoremap <buffer> <CR> <CR>:cclose<CR> ]]
})
