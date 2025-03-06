{
    description = "System Configuration";

    inputs = {
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        nixpkgs.url = "nixpkgs/nixos-24.11";
        # nixos-cosmic = {
        #     url = "github:lilyinstarlight/nixos-cosmic";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };
    };

    outputs = inputs@{ nixpkgs, nixpkgs-unstable, ... }: let
        inherit (nixpkgs-unstable) lib;
        system = "x86_64-linux";
        pkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
        stable = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
        nixosConfigurations = {
            "nixosPC" = lib.nixosSystem {
                inherit system;
                specialArgs = { inherit stable; };
                modules = [
                    ./system/nixosPC.nix
                    # { nix.settings = {
                    #     substituters = [ "https://cosmic.cachix.org/" ];
                    #     trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                    # };}
                    # nixos-cosmic.nixosModules.default
                ];
            };
        };
    };
}
