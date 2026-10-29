{ lib, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Tell your laptop to prefer using distributed builders over its own CPU
      builders-use-substitutes = true;
    };

    buildMachines = [
      {
        hostName = "100.68.87.6"; # tailscale IP
        sshUser = "nix-builder";
        protocol = "ssh-ng";
        system = "x86_64-linux";
        sshKey = "/root/.ssh/id_nix_builder";
        maxJobs = 8;
        speedFactor = 2;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
      }
    ];

    distributedBuilds = true;
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 14d --keep 3";
    };
    flake = "/home/gurvanbk/nix-config";
  };
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "1password-gui"
      "discord"
      "discord-unwrapped"
      "slack"
      "vscode"
      "idea"
      "clion"
      "steam"
      "steam-unwrapped"
      "plex-desktop"
      "hplip"
      "pantum-driver"
      "stm32cubemx"
      "lens-desktop"
      "quartus-prime-lite"
      "quartus-prime-lite-unwrapped"
    ];

  programs.nix-ld.enable = true;
  services.envfs.enable = true;
  documentation.dev.enable = true;
}
