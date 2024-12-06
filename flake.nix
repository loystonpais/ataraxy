{
  description = "A discord bot written in rust";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      #nixpkgsFor = forAllSystems (system: nixpkgs.legacyPackages );

      packages = forAllSystems (system: { default = import ./default.nix { pkgs = nixpkgsFor.${system}; }; });
  in {
    inherit packages;
  };


}