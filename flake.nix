# SPDX-FileCopyrightText: 2020 Serokell <https://serokell.io/>
#
# SPDX-License-Identifier: MPL-2.0

{
  edition = 201911;

  description = "A Nix flake for haskell.nix";

  outputs = { self, nixpkgs, haskell-nix }:
    let
      pkgs = nixpkgs { config = {}; overlays = []; };
    in {
      lib = rec {
        cleanSourceWith = (import "${haskell-nix.outPath}/lib/clean-source-with.nix" {
          inherit (pkgs) lib;
        }).cleanSourceWith;
        cleanGit = import "${haskell-nix.outPath}/lib/clean-git.nix" {
          inherit (pkgs) lib;
          inherit (pkgs) runCommand git;
          inherit cleanSourceWith;
        };
      };
    };
}
