{
  pkgs,
  inputs,
  ...
}:
let
  agy-wrapped = pkgs.symlinkJoin {
    name = "google-antigravity-cli-wrapped";
    paths = [ inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-cli ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/agy \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.glab ]}
    '';
  };
in
{
  home.packages = [
    agy-wrapped
  ];
}
