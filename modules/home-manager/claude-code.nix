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
    agentsDir = ./claude-agents;
  };

  # Remove once Claude Code supports ACP and the antigravity agent uses `agy acp`.
  systemd.user.services.claude-acp-check = {
    Unit.Description = "Check Claude Code changelog for ACP support";
    Service = {
      Type = "oneshot";
      ExecStart = toString (
        pkgs.writeShellScript "claude-acp-check" ''
          log=$(${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md)
          if ${pkgs.gnugrep}/bin/grep -qiE '\bacp\b|agent client protocol' <<<"$log"; then
            ${pkgs.libnotify}/bin/notify-send "Claude Code supports ACP" \
              "Switch the antigravity subagent to agy acp, then remove claude-acp-check from claude-code.nix"
          fi
        ''
      );
    };
  };
  systemd.user.timers.claude-acp-check = {
    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
