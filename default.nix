{
  hask-proj   = import ./hask-proj.nix;    # Utility to turn cabal2nix output into dev-env's
  pin-nixpkgs = import ./pin-nixpkgs.nix;  # Return the path to a particular revision of nixpkgs
}
