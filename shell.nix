{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gcc
  ];

  nativeBuildInputs = with pkgs.buildPackages; [ gcc ];

  CC="gcc";

  shellHook = ''
  export PATH="$PATH":~/.cargo/bin
  '';
}
