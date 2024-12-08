{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    rustc
    cargo
    rustup
  ];

  nativeBuildInputs = with pkgs.buildPackages; [ gcc ];
}
