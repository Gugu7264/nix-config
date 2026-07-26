{
  description = "Nixos config flake";

  inputs = {
    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        thinkpad-p14s = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/thinkpad-p14s/default.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                users.gurvanbk = import ./home/gurvanbk/default.nix;
              };
            }
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen5
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        name = "nix-config-dev";
        packages = with nixpkgs.legacyPackages.x86_64-linux; [
          git
        ];
        shellHook = ''
          if [ -d .git ] && [ ! -f .git/hooks/pre-commit ]; then
            mkdir -p .git/hooks
            cat << 'EOF' > .git/hooks/pre-commit
#!/usr/bin/env bash
set -e
echo "Running statix and deadnix checks..."
nix run nixpkgs#statix -- check .
nix run nixpkgs#deadnix -- .
EOF
            chmod +x .git/hooks/pre-commit
            echo "Installed pre-commit hook in .git/hooks/pre-commit"
          fi
        '';
      };
    };
}
