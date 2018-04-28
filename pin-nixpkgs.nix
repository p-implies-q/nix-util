# Return the path to a particular version of nixpkgs

# Use nix-prefetch-git https://github.com/nixos/nixpkgs.git to find sha256
{ rev , sha256 }:

(import <nixpkgs> { }).fetchFromGitHub {
  owner = "NixOS";
  repo = "nixpkgs";
  inherit rev sha256;
}
