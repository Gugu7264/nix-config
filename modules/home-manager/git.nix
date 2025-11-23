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
      rebase.autostash = true;
      init.defaultbranch = "main";
    };
  };
}
