{
  inputs = {
    nixpkgs.url = "nixpkgs/807c549feabc";
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
                            stdenv.cc.cc.lib
                            cudatoolkit
                            julia
                            cudaPackages.cuda_sanitizer_api
                            cudaPackages.cuda_cudart
                            nvtop
                          ];
            LD_LIBRARY_PATH="${stdenv.cc.cc.lib}/lib:/run/opengl-driver/lib:${cudaPackages.cuda_cudart}/lib";
          };
        }
      );
}
