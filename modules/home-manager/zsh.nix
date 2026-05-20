{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-autocomplete
    bat
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    historySubstringSearch = {
      enable = true;
      searchUpKey = [
        "^[[A"
        "^[OA"
      ];
      searchDownKey = [
        "^[[B"
        "^[OB"
      ];
    };

    history = {
      size = 1000000;
      save = 1000000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true; # Share history between different sessions
      extended = true; # Save timestamps for each command
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

    initContent = ''
      export MANPAGER='sh -c "col -bx | bat -l man -p"'
      export MANROFFOPT="-c"

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      submit () { git tag -ma "$1" && git push "$1" }

      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    initExtra = ''
      # Don't record a line if it's a duplicate of the previous one
      setopt HIST_IGNORE_DUPS
      # Remove older duplicate entries from history
      setopt HIST_IGNORE_ALL_DUPS
      # Don't write duplicate entries in the history file
      setopt HIST_SAVE_NO_DUPS
      # Delete old recorded entry if new entry is a duplicate
      setopt HIST_FIND_NO_DUPS
      # Don't record an entry starting with a space
      setopt HIST_IGNORE_SPACE
    '';

    shellAliases = {
      cat = "bat -P";
      v = "nvim";

      # Git aliases
      ga = "git add";
      gc = "git commit";
      gss = "git status --short";
      gs = "git status";
      grbc = "git rebase --continue";
      grba = "git rebase --abort";
      grbom = "git rebase origin/main";
      gsw = "git switch";
      gsm = "git switch main";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gpf = "git push --force-with-lease --force-if-includes";
      gf = "git fetch";
      gbgd = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      gbgD = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D";
      gb = "git branch";
      grpo = "git remote prune origin";
      gorush = "cd /home/gurvanbk/epita/YAKA/rush-creeps";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
