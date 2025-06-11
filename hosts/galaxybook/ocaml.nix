{pkgs, ...}: {
  environment.systemPackages = with pkgs.ocamlPackages; [
    ocaml
    dune_3
    findlib
    utop
    pkgs.ocamlformat
  ];
}
