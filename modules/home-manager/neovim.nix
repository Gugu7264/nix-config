{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.editor.neovim;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  options.editor.neovim = {
    enable = mkEnableOption "Enable Neovim with NVF";
  };

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      defaultEditor = true;
      settings.vim = {
        lineNumberMode = "relNumber";

        luaConfigPost = ''
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.json",
            callback = function()
              if vim.fn.executable("jq") ~= 1 then
                vim.notify("jq not found in PATH", vim.log.levels.WARN)
                return
              end

              -- Save current buffer content
              local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
              local input = table.concat(lines, "\n")

              -- Run jq on the content
              local jq = vim.fn.system("jq '.'", input)

              -- Check exit code
              if vim.v.shell_error == 0 then
                -- Replace buffer with jq output
                vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(jq, "\n"))
              else
                -- Do not modify, show error
                vim.notify("Failed to format JSON: " .. jq, vim.log.levels.ERROR)
              end
            end,
          })

          vim.filetype.add({extension = {tig = "tiger", tih = "tiger"}})
        '';

        extraPackages = [
          pkgs.jq
          pkgs.php83Packages.php-cs-fixer
        ];

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lspSignature.enable = true;
          trouble.enable = true;
          lightbulb.enable = true;
        };

        diagnostics = {
          enable = true;
          config.virtual_lines = true;
        };

        telescope.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          clang.enable = true;
          nix = {
            enable = true;
            treesitter.enable = false; # creates indentation issues if activated
          };
          markdown.enable = true;
          bash.enable = true;
          python.enable = true;
          php = {
            enable = true;
          };
          ocaml = {
            enable = true;
            lsp.enable = false;
            treesitter.enable = true;
            format.enable = true;
          };
        };

        treesitter = {
          enable = true;
          grammars = [
            pkgs.tree-sitter-grammars.tree-sitter-tiger
            pkgs.tree-sitter-grammars.tree-sitter-json
          ];
        };

        git = {
          enable = true;
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        visuals = {
          nvim-web-devicons.enable = true; # enable icons (eg. for files)
          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        presence.neocord.enable = true;
      };
    };
  };
}
