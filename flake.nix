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

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maomaowm = {
      url = "github:Gugu7264/maomaowm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/galaxybook/default.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {inherit inputs;};
              users.gurvanbk = import ./home/gurvanbk/default.nix;
            };
          }
        ];
      };
      thinkpad-p14s = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad-p14s/default.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {inherit inputs;};
              users.gurvanbk = import ./home/gurvanbk/default.nix;
            };
          }
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen5
          # ({pkgs, ...}: {
          #   nixpkgs.overlays = [
          #     (final: prev: {
          #       jetbrains =
          #         prev.jetbrains
          #         // {
          #           idea-ultimate = prev.jetbrains.idea-ultimate.overrideAttrs (old: {
          #             version = "2025.3-RC";
          #             src = prev.fetchurl {
          #               url = "https://download.jetbrains.com/idea/ideaIU-2025.1.7.tar.gz";
          #               sha256 = "sha256-VNr0K0Mu8SfyeLm79HNdipv5xsx0cqeXvdvgCCmeINI=";
          #             };
          #           });
          #         };
          #     })
          #   ];
          # })
        ];
      };
    };
  };
}
