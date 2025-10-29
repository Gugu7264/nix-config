{
  pkgs,
  lib,
  ...
}: {
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

      submit () { git tag -ma "$1" && git push "$1" }

      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

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
    };
  };
}
