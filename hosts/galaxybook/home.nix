{
  config,
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gurvanbk";
  home.homeDirectory = "/home/gurvanbk";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-autocomplete
    bat
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^[[A" "^[OA"];
      searchDownKey = ["^[[B" "^[OB"];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];

    localVariables = {
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "(none)";
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "(none)";
      HISTORY_SUBSTRING_SEARCH_PREFIXED = "true";
      HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = "true";
    };

    initContent = lib.mkAfter ''
      export MANPAGER='sh -c "col -bx | bat -l man -p"'
      export MANROFFOPT="-c"

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    shellAliases = {
      cat = "bat -P";
      v = "nvim";

      # Git aliases
      ga = "git add";
      gc = "git commit";
      gss = "git status --short";
      gs = "git status";
      grbc = "git rebase continue";
      grba = "git rebase abort";
      grbom = "git rebase origin/main";
      gsw = "git switch";
      gsm = "git switch main";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gpf = "git push --force-with-lease --force-if-includes";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
