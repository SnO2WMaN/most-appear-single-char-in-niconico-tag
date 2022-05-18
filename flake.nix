{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
  outputs = { self, nixpkgs, flake-utils, devshell, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell =
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              devshell.overlay
            ];
          };
        in
        pkgs.devshell.mkShell {
          devshell.packages = with pkgs; [
            poetry
          ];
          commands = [
            {
              name = "generate";
              help = "update result.txt";
              command = "poetry run python ./fetch.py | sort -rn > $PRJ_ROOT/result.txt";
            }
          ];
        };
    });
}
