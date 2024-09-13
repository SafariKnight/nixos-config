{config, ...}: {
  programs.nixvim = {
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2

      mapleader = " ";
    };
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    opts = {
      # Better Searching
      hlsearch = false;
      incsearch = true;

      # Preview Substitions
      inccommand = "split";

      number = true;
      relativenumber = true;

      mouse = "";

      swapfile = false;
      backup = false;

      undofile = true;
      undodir = config.lib.nixvim.mkRaw ''vim.fn.expand("~") .. "/.vim/undodir"'';

      breakindent = true;

      smartindent = true; # please do your best neovim

      wrap = false;

      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";

      updatetime = 50;
      timeout = true;
      timeoutlen = 800;

      tabstop = 2;
      softtabstop = 0;
      shiftwidth = 2;
      expandtab = true;

      termguicolors = true;

      scrolloff = 9999;

      splitright = true;
      splitbelow = true;

      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };

      cursorline = false;

      foldmethod = "marker";

      showmode = true;

      cmdheight = 0;
      laststatus = 0;
      ruler = false;
    };
  };
}
