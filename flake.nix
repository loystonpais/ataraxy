{
  description = "A discord bot written in rust";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      packages = forAllSystems (system: { default = import ./default.nix { pkgs = nixpkgsFor.${system}; }; });
  in {
    inherit packages;
  };


}