_: {
  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      format = "openpgp";
    };
    settings = {
      user.email = "gurvan.biguet-kerloch@epita.fr";
      user.name = "Gurvan Biguet--Kerloc'h";
      pull.rebase = true;
      rebase.autostash = true;
      init.defaultbranch = "main";
      alias = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
      };
    };
  };
}
