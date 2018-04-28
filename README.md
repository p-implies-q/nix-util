# Just a small set of utilities for nix and haskell

If you're here looking for a solution to get haskell development working well
and comfortably, behold the result of my struggles!

Given a simple haskell project with a cabal-file, use `cabal2nix . >
my-proj.nix` in the project directory to autogenerate a nix-derivation
describing the project. Then pass the path to that nix expression to hask-proj
to generate a development environment. Here is a small example:

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

Note that this is not a finished product at all. I'd like to add profiling and
hoogle flags to make this extra-simple, but I haven't got the time for that
anytime soon. At the moment, if you want to fine-tune the setting up of a
haskell development environment, you're probably best off just editing the
`hask-proj.nix` function, or if you're better at Nix than I am (not too hard,
very new to this) just hand-roll your own setup.
