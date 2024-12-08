{ pkgs ? import <nixpkgs> { } }:
pkgs.pkgsStatic.rustPlatform.buildRustPackage rec {
  pname = "ataraxy";
  version = "v0.0.0.pre-alpha";
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
}
