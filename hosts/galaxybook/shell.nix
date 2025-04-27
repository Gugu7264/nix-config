{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zsh-powerlevel10k # theme
    # zsh-syntax-highlighting
    # zsh-autosuggestions
  ];

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';
      ohMyZsh = {
        enable = false;
        plugins = ["git colored-man-pages"];
      };
      shellAliases = {
        cat = "bat -P";
        v = "nvim";
      };
    };
  };
}
