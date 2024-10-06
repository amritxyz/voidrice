local fn = vim.fn

-- Define the path where packer.nvim should be installed
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- Function to ensure packer.nvim is installed
local function ensure_packer()
  -- Check if packer.nvim is already installed
  if fn.empty(fn.glob(packer_path)) > 0 then
    print("Cloning packer.nvim...")

    -- Create the directory if it does not exist
    local packer_dir = fn.fnamemodify(packer_path, ':h')
    if fn.empty(fn.glob(packer_dir)) > 0 then
      fn.system({'mkdir', '-p', packer_dir})
    end

    -- Clone packer.nvim repository
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      packer_path
    })

    -- Load packer.nvim after installing
    vim.cmd [[packadd packer.nvim]]
  end
end

-- Ensure packer.nvim is installed
ensure_packer()

-- After packer is installed, we can safely require it and setup plugins
-- Set leader key
vim.g.mapleader = ","

-- Plugin management with packer.nvim
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Plugins
  use 'tpope/vim-surround'
  use 'preservim/nerdtree'
  use 'junegunn/goyo.vim'
  use 'jreybert/vimagit'
  use 'vimwiki/vimwiki'
  use 'vim-airline/vim-airline'
  use 'tpope/vim-commentary'
  use 'ap/vim-css-color'
end)

-- Automatically install vim-plug if not installed
local plug_path = vim.fn.expand('$XDG_CONFIG_HOME/nvim/autoload/plug.vim')
if not vim.fn.filereadable(plug_path) then
  print("Downloading junegunn/vim-plug to manage plugins...")
  vim.fn.mkdir(vim.fn.expand('$XDG_CONFIG_HOME/nvim/autoload'), 'p')
  vim.fn.system('curl -fLo ' .. plug_path .. ' --create-dirs ' .. 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.cmd('PlugInstall')
end

-- Basic settings
vim.opt.title = true
vim.opt.background = 'dark'
vim.opt.mouse = 'a'
vim.opt.hlsearch = false
vim.opt.clipboard:append('unnamedplus')
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.cmd('colorscheme vim')

-- Basic settings
vim.opt.title = true
vim.opt.background = 'dark'
vim.opt.mouse = 'a'
vim.opt.hlsearch = false
vim.opt.clipboard:append('unnamedplus')
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.cmd('colorscheme vim')

-- Key mappings
vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = 'longest,list,full'
vim.cmd('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')
vim.api.nvim_set_keymap('v', '.', ':normal .<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Goyo | set bg=light | set linebreak<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>o', ':setlocal spell! spelllang=en_us<CR>', { noremap = true })
vim.opt.splitbelow = true
vim.opt.splitright = true

-- NERDTree and other settings
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true })
vim.cmd('autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')

-- Split navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Other settings and mappings
vim.api.nvim_set_keymap('n', 'Q', 'gq', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>o', 'ZQ', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':!clear && shellcheck -x %<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':vsp<space>$BIB<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':vsp<space>$REFER<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'S', ':%s//g<Left><Left>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':w! | !compiler "%:p"<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', ':!opout "%:p"<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':vsplit <C-r>=expand("%:p:h").."/"<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<S-n>', ':split <C-r>=expand("%:p:h").."/"<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<S-h>', ':vertical resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-l>', ':vertical resize -5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-k>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-j>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':r ~/.config/nvim/snippets/<C-d>', { noremap = true, silent = true })

vim.cmd('cabbrev w!! execute "silent! write !sudo tee % >/dev/null" <bar> edit!')

-- Toggle hidden statusbar
local hidden_all = false
function _G.toggle_hidden_all()
  hidden_all = not hidden_all
  vim.opt.showmode = not hidden_all
  vim.opt.ruler = not hidden_all
  vim.opt.laststatus = hidden_all and 0 or 2
  vim.opt.showcmd = not hidden_all
end
vim.api.nvim_set_keymap('n', '<leader>h', ':lua toggle_hidden_all()<CR>', { noremap = true })

-- Vimwiki and filetype settings
vim.g.vimwiki_ext2syntax = { ['.Rmd'] = 'markdown', ['.rmd'] = 'markdown', ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown' }
vim.g.vimwiki_list = { { path = '~/.local/share/nvim/vimwiki', syntax = 'markdown', ext = '.md' } }
vim.cmd('autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown')
vim.cmd('autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff')
vim.cmd('autocmd BufRead,BufNewFile *.tex set filetype=tex')
vim.cmd([[
  autocmd BufWritePre * let currPos = getpos(".")
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
  autocmd BufWritePre *.[ch] %s/\%$/\r/e
  autocmd BufWritePre *neomutt* %s/^--$/-- /e
  autocmd BufWritePre * call cursor(currPos[1], currPos[2])
]])
vim.cmd([[if &diff | highlight! link DiffText MatchParen | endif]])
vim.cmd([[
  autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo 80 | call feedkeys("jk")
  autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo!\|x!<CR>
  autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo!\|q!<CR>
]])
vim.cmd('silent! source ~/.config/nvim/shortcuts.vim')
