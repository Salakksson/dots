vim.opt.guifont = "SauceCodePro Nerd Font:h23"

local function map_all(modes, lhs, rhs, opts)
	opts = opts or {}
	for _, mode in ipairs(modes) do
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

local nav_modes = { "i", "n", "v" }
local cmd_modes = { "c" }
local all_modes = { "i", "n", "v", "c"}

map_all(all_modes, "<M-x>", "<Esc>:")

map_all(all_modes, "<C-c>e", function()
	dofile(vim.fn.stdpath("config") .. "/init.lua")
end)

map_all(all_modes, "<C-a>", "<Home>")
map_all(all_modes, "<C-e>", "<End>")
map_all(all_modes, "<C-b>", "<Left>")
map_all(all_modes, "<C-f>", "<Right>")
map_all(all_modes, "<C-n>", "<Down>")
map_all(all_modes, "<C-p>", "<Up>")

map_all(all_modes, "<C-d>", "<Del>")
map_all(all_modes, "<M-f>", "<C-o>w")
map_all(all_modes, "<M-b>", "<C-o>b")
map_all(all_modes, "<M-d>", "<C-o>dw")

map_all(all_modes, "<C-Space>", "<Esc>v")

map_all(all_modes, "<C-x><C-c>", "<Esc>:q!")
map_all(all_modes, "<C-x><C-s>", "<Esc>:w")

map_all(all_modes, "<C-g>", "<Esc>")
map_all(all_modes, "<C-c>d", "<Esc>:Ex")

vim.keymap.set("i", "<C-k>", function()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	if line:match("^%s*$") then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>ddi", true, false, true), "n", true)
		vim.cmd("startinsert")
	else
		local new_line = line:sub(1, col)
		vim.api.nvim_set_current_line(new_line)
	end
end, { noremap = true, silent = true })

vim.cmd([[
	set number relativenumber

	set cursorline

	set noexpandtab
	set tabstop=6
	set shiftwidth=6
	set softtabstop=6

	set list
	set listchars=tab:»\ ,space:·
	" nnoremap <leader>l :set list!<CR>
	set termguicolors

	set clipboard+=unnamedplus

	set laststatus=0

]])

	-- colorscheme tokyonight-night

	-- highlight NvimTreeNormal guibg=NONE ctermbg=NONE
	-- highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
	-- highlight Normal guibg=NONE ctermbg=NONE
	-- highlight NormalNC guibg=NONE ctermbg=NONE
	-- highlight VertSplit guibg=NONE ctermbg=NONE

	-- " highlight CursorLine guibg=NONE ctermbg=NONE
	-- " highlight CursorLineNr guibg=NONE ctermbg=NONE

	-- highlight BufferTabpageFill guibg=NONE ctermbg=NONE

	-- highlight BufferInactive guibg=NONE ctermbg=NONE
	-- highlight BufferInactiveSign guibg=NONE ctermbg=NONE
	-- highlight BufferInactiveMod guibg=NONE ctermbg=NONE
	-- highlight BufferInactiveIndex guibg=NONE ctermbg=NONE

	-- highlight BufferCurrent guibg=NONE ctermbg=NONE
	-- highlight BufferCurrentSign guibg=NONE ctermbg=NONE
	-- highlight BufferCurrentMod guibg=NONE ctermbg=NONE
	-- highlight BufferCurrentIndex guibg=NONE ctermbg=NONE

	-- hi TabLine guibg=NONE ctermbg=NONE
	-- hi TabLineSel guibg=NONE ctermbg=NONE
	-- hi TabLineFill guibg=NONE ctermbg=NONE
