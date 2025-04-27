{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.editor.neovim;
in {
  imports = [
    inputs.nvf.nixosModules.default
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
          enableLSP = true;
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
