# This is my attempt to write a function that:
# - takes the output of a cabal2nix call
# - adds some development dependencies
# - pins nixpkgs to a particular revision
# - builds the environment


{ rev                    # The git revision of nixpkgs to fix to
, sha256                 # The sha256 for the same, use nix-prefetch-git to find this
, proj-path              # The path to the project's cabal2nix output
, compiler    ? "ghc842" # The compiler to use
, nix-config  ? {}       # Arguments to pass to nixpkgs
, proj-config ? {}       # Arguments to pass to the project being called
, extra-tools ? []       # Extra derivations to insert into buildTools
}:

let
  # Import libraries
  pin-it  = import ./pin-nixpkgs.nix;
  nixpkgs = import (pin-it { inherit rev sha256; }) { config = nix-config; };

  # Define easy shortcuts
  lib     = nixpkgs.pkgs.haskell.lib;
  hpkgs   = nixpkgs.pkgs.haskell.packages.${compiler};

  # Import the derivation for the project
  proj    = hpkgs.callPackage (import proj-path) proj-config;

  # Define the tools to be inserted
  devtools = extra-tools ++ (with nixpkgs.haskellPackages;
    [ cabal2nix cabal-install ghcid hoogle        # devtools
      htags apply-refact stylish-haskell ]);      # emacs integration
in
  # Return a new derivation with the inserted tools
  lib.overrideCabal proj (old: { buildTools = devtools ++ (old.buildTools or []); })
