{ pkgs ? import <nixpkgs> { } }:
with builtins;
let 
  cargoToml = fromTOML ( readFile ./bot/Cargo.toml );

  pname = cargoToml.package.name;
  version = cargoToml.package.version;
  
in
pkgs.pkgsStatic.rustPlatform.buildRustPackage rec {
  inherit pname version;
  
  cargoLock.lockFile = ./bot/Cargo.lock;
  src = ( pkgs.lib.cleanSource ./bot );
}
