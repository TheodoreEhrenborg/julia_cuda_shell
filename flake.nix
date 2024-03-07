{
  inputs = {
    nixpkgs.url = "nixpkgs/ab5b6828af26215";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, nixpkgs-stable}:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          pkgs-stable = import nixpkgs-stable {
            inherit system;
          };
        in
        with pkgs;
        {
          devShells.default = mkShell {
            buildInputs = [
                            cudatoolkit
                            pkgs-stable.julia
                          ];
      LD_LIBRARY_PATH="/run/opengl-driver/lib";
          };
        }
      );
}
