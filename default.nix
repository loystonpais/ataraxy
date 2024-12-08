{ pkgs ? import <nixpkgs> { } }:
with builtins;
let 
  cargoToml = fromTOML ( readFile ./Cargo.toml );

  pname = cargoToml.package.name;
  version = cargoToml.package.version;
  
in
pkgs.pkgsStatic.rustPlatform.buildRustPackage rec {
  inherit pname version;
  
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
}
