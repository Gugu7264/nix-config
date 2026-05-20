{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ attic-client ];
  nix.settings = {
    substituters = [
      "http://10.201.3.150:8000/yaka-cache"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "yaka-cache:sRTS8g4S0vP5WzVW4kIJ1C+PR9y2AS+2WpC3G2gXB7g="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nix.buildMachines = [
    {
      hostName = "10.201.3.146";
      sshUser = "nix-builder";
      protocol = "ssh-ng";
      # Tell Nix what architectures this builder can compile
      system = "x86_64-linux";
      sshKey = "/root/.ssh/id_nix_builder";
      # Let Nix know this machine is fast
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

  nix.distributedBuilds = true;

  # Tell your laptop to prefer using distributed builders over its own CPU
  nix.settings.builders-use-substitutes = true;

}
