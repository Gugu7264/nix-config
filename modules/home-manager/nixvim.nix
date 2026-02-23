{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    defaultEditor = true;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
      };
    };

    extraPackages = with pkgs; [
      jq
      nixfmt
      black
    ];

    opts = {
      number = true; # Show line numbers
      relativenumber = true; # Relative line numbers (great for movement)
      shiftwidth = 2; # Tab width should be 2
      tabstop = 2;
      expandtab = true; # Use spaces instead of tabs
      smartindent = true; # Auto-indent new lines
      ignorecase = true; # Ignore case in searches...
      smartcase = true; # ...unless there's a capital letter
      swapfile = false; # Modern editors don't really need swapfiles
      undofile = true; # Persistent undo history
    };

    globals.mapleader = " ";

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    lsp.servers = {
      bashls.enable = true;
      clangd.enable = true;
      dockerls.enable = true;
      jsonls.enable = true;
      marksman.enable = true;
      nixd.enable = true;
      pylsp.enable = true;
      yamlls.enable = true;
    };

    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];
      };

      oil.enable = true;

      lualine.enable = true;

      # Setup Language Server Protocol (LSP)
      lspconfig.enable = true;

      # Enable Treesitter for better syntax highlighting
      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };

      which-key.enable = true;
      notify.enable = true;

      web-devicons.enable = true;

      bufferline.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      todo-comments.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };

          formatters_by_ft = {
            python = ["black"];
          };
        };
      };
    };
  };
}
