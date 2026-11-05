{ pkgs, ... }:
let
  claude-code-wrapped = pkgs.symlinkJoin {
    name = "claude-code-wrapped";
    inherit (pkgs.claude-code) version;
    paths = [ pkgs.claude-code ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    # Appended, so a project's devShell node or glab takes precedence.
    postBuild = ''
      wrapProgram $out/bin/claude \
        --suffix PATH : ${
          pkgs.lib.makeBinPath [
            pkgs.glab
            pkgs.nodejs
          ]
        }
    '';
  };
in
{
  programs.claude-code = {
    enable = true;
    package = claude-code-wrapped;
    rulesDir = ./claude-rules;
  };
}
