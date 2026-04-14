{
  description = "Alice's Nixtop";

  inputs = {
    # Stable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # Unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Nixpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    #AliceVim
    avim = {
          url = "git+https://codeberg.org/sheep/avim";
          inputs.nixpkgs.follows = "nixpkgs";
    };
    # Home Manger
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, avim, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.wonderland = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs unstable-pkgs; };
      modules = [
        ./hardware-configuration.nix # KEEP YOUR ORIGINAL FILE!
        ./configuration.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.alice = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs unstable-pkgs; };
        }
      ];
    };
  };
}
