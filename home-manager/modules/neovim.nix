{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    package = pkgs.neovim-unwrapped;  # Use unwrapped version

    plugins = with pkgs.vimPlugins; [
      # Plugin Section
      vim-easy-align
      nerdtree
      vim-elixir
      vim-go
      vim-reason-plus
      vim-gitgutter
      gruvbox
      vim-nerdtree-syntax-highlight
      vim-javascript
      vim-jsx
      coc-nvim
      vim-devicons
    ];

    extraConfig = ''
      " ============================================================================
      " GLOBAL CONFIGURATION
      " ============================================================================
      " enable syntax highlighting
      syntax enable

      " set the window's title, reflecting the file currently being edited
      set title

      " Use an encoding that supports Unicode
      set encoding=utf-8

      " show the line number
      set number

      " show cursor line
      set cursorline

      " Always show cursor position
      set ruler

      " when scrolling, keep cursor 5 lines away from screen border
      set scrolloff=5

      " show the tab bar
      set showtabline=2

      " makes copy and paste work better
      set clipboard=unnamedplus

      " automatic indentation
      set autoindent
      set smartindent

      " use spaces instead of tabs
      set expandtab
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4

      " use tabs at the start of a line, spaces elsewhere
      set smarttab

      " don't wrap text
      set nowrap

      " don't fold code
      set nofoldenable

      " make completion smarter
      set ignorecase
      set smartcase

      " Automatically re-open files after they have changed without prompting
      set autoread

      " disable beep on errors
      set noerrorbells
      set novisualbell
      set termguicolors

      " needed so deoplete can auto select the first suggestion
      set completeopt+=noinsert
      set completeopt-=preview

      " autocompletion of files and commands behaves like shell
      set wildmode=list:longest

      " fix problems with uncommon shells and plugins running commands
      set shell=${pkgs.bash}/bin/bash

      " if hidden is not set, TextEdit might fail
      set hidden

      " Better display for messages
      set cmdheight=2

      " Smaller updatetime for CursorHold & CursorHoldI
      set updatetime=300

      " don't give |ins-completion-menu| messages
      set shortmess+=c

      " always show signcolumns
      set signcolumn=yes

      " enable mouse
      set mouse=a

      " Theme and Colorscheme
      colorscheme gruvbox

      " NERDTree Configuration
      let NERDTreeShowHidden=1

      hi xmlAttrib cterm=italic ctermfg=214

      " Auto open NERDTree in vim
      function! StartUp()
          if 0 == argc()
              NERDTree
          end
      endfunction

      " Tab completion
      inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " coc config
      let g:coc_global_extensions = [
        \ 'coc-snippets',
        \ 'coc-pairs',
        \ 'coc-tsserver',
        \ 'coc-eslint',
        \ 'coc-prettier',
        \ 'coc-json',
        \ ]

      " Use <c-space> to trigger completion
      inoremap <silent><expr> <c-space> coc#refresh()
      autocmd VimEnter * call StartUp()
    '';

    # For NERD font support
    extraPackages = with pkgs; [
      # Fonts (optional)
      nerdfonts
      # Language servers (for coc.nvim)
      nodejs
    ];
  };
}