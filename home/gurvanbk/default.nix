_: {
  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/walker.nix
    ../../modules/home-manager/niri.nix
    ../../modules/home-manager/mako.nix
    ../../modules/home-manager/alacritty.nix
    # ../../modules/home-manager/kanshi.nix
  ];

  home = {
    username = "gurvanbk";
    homeDirectory = "/home/gurvanbk";
    stateVersion = "24.11";
  };

  editor.neovim.enable = true;

  programs.home-manager.enable = true;
}
