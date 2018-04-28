# Just a small set of utilities for nix and haskell

If you're here looking for a solution to get haskell development working well
and comfortably, behold the result of my struggles!

Given a simple haskell project with a cabal-file, use cabal2nix to autogenerate
a nix-derivation describing the project. Then pass the path to that nix
expression to hask-proj to generate a development environment. Here is a small
example:

`default.nix`
```
let
  rev      = "7673593c85623fa7065ea7ef56bcd0a50f2fbea1";
  sha256   = "0fc8jgiypb5jima4i719n61qhig684hxq3rk9kyda4zvsr5lh3f0";
  compiler = "ghc842";

  util     = import /path/to/this/repo/nix-util;
in
  util.hask-proj {
    proj-path = ./my-proj.nix;
    inherit rev sha256 compiler;
  }
```

`shell.nix`
```
(import ./default.nix).env
```
