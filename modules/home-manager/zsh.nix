{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.homeModules.default
  ];

  home.packages = with pkgs; [
    zsh-autocomplete
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    zsh = {
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
        path = "${config.home.homeDirectory}/.zsh_history";
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
      ];

      localVariables = {
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "(none)";
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "(none)";
        HISTORY_SUBSTRING_SEARCH_PREFIXED = "true";
        HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = "true";
      };

      initContent = ''
        # Don't record a line if it's a duplicate of the immediate previous one
        setopt HIST_IGNORE_DUPS
        # Expire duplicate entries first when max history capacity is reached
        setopt HIST_EXPIRE_DUPS_FIRST
        # Immediately write commands to disk upon execution with duration/timestamps
        setopt INC_APPEND_HISTORY_TIME
        # Don't record an entry starting with a space
        setopt HIST_IGNORE_SPACE

        export MANPAGER='sh -c "col -bx | bat -l man -p"'
        export MANROFFOPT="-c"

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        submit() {git tag -m "$1" "$1" && git push && git push origin "$1"}
        gbgD() {
          git fetch -p

          # Prune any stale worktree metadata for deleted directories
          git worktree prune

          # Find all local branches whose upstream is [gone]
          git for-each-ref --format="%(refname:short) %(upstream:track)" refs/heads |
            awk '$2 == "[gone]" {print $1}' |
            while read -r branch; do
              [[ -z "$branch" ]] && continue

              # Find if this branch is linked to an active worktree path
              wt_path=$(git worktree list --porcelain | awk -v b="refs/heads/$branch" '
                /^worktree / { path = substr($0, 10) }
                /^branch / && $2 == b { print path }
              ')

              if [[ -n "$wt_path" ]]; then
                echo "Removing worktree for '$branch' at $wt_path..."
                git worktree remove --force "$wt_path"
              fi

              echo "Deleting branch '$branch'..."
              git branch -D "$branch"
            done
        }

        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

        # Enable completion for alias k=kubectl
        (( $+commands[kubectl] )) && compdef _kubectl k

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';

      shellAliases = {
        # cat = "bat -P";
        v = "nvim";
        k = "kubectl";

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
        gb = "git branch";
        grpo = "git remote prune origin";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        search_mode = "fuzzy";
        filter_mode = "global";
        workspaces = true;
        inline_height = 16;
        show_preview = true;
        style = "compact";
        enter_accept = false;
      };
    };

    nix-index-database.comma.enable = true;
    nix-index.enable = true;
  };
}
