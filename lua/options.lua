-- any standalone option

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false

-- Indentation
-- Enable break indent
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = false
local size = 4
vim.opt.tabstop = size
vim.opt.softtabstop = size
vim.opt.shiftwidth = size

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("$HOME/.vim.undodir")

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
-- NOTE: this will allow highlight the CursorLineNr
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 18

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = false

vim.o.completeopt = "menuone,noselect"

-- Reload file when changed
vim.opt.autoread = true

-- " Don't wrap lines
vim.opt.wrap = false
-- " Wrap lines at convenient points
vim.opt.linebreak = true
-- " Show line breaks
vim.opt.showbreak = "↳"

-- Remove the `~` when there is not text
vim.opt.fillchars:append({ eob = " " })

-- Remove the cmd bar at bottom ?
vim.opt.cmdheight = 0

vim.opt.colorcolumn = "120"

vim.opt.swapfile = false

vim.opt.conceallevel = 3
vim.cmd [[
autocmd BufEnter *.json setlocal conceallevel=0
]]

vim.opt.foldmethod = "marker"

-- Spellchecking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Show the winbar for file
-- vim.opt.winbar = "%= %m %f"

-- Porting what I already have in .vimrc, TODO: clean up
vim.cmd([[
" function! CentreCursor()
"     let pos = getpos(".")
"     normal! zz
"     call setpos(".", pos)
" endfunction
" :autocmd CursorMoved,CursorMovedI * call CentreCursor()


" Do not yank the replaced text
vnoremap p "_dP

" Stay in visual when indenting
vnoremap > >gv
vnoremap < <gv

" Redo
nnoremap U <C-r>

nmap vaa gg^vG$

nnoremap <SPACE> <Nop>

" No clue
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzzzv
nnoremap N Nzzzv

nmap dsp :split<CR>
nmap rsp :vsplit<CR>

]])

vim.cmd [[
  au BufNewFile,BufRead *.ers setlocal ft=rust
]]


-- Disable auto commenting for newline
vim.cmd("set formatoptions-=cro")
vim.cmd("autocmd BufEnter,BufRead * set formatoptions-=cro")
vim.cmd("autocmd BufEnter,BufRead * setlocal formatoptions-=cro")
