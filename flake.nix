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
     git gitRepo gnupg autoconf curl
     procps gnumake util-linux m4 gperf unzip
     cudatoolkit linuxPackages.nvidia_x11
     libGLU libGL
     xorg.libXi xorg.libXmu freeglut
     xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
     ncurses5 stdenv.cc binutils
     pkgs-stable.julia
                          ];
    CUDA_PATH=pkgs.cudatoolkit;
      LD_LIBRARY_PATH="/run/opengl-driver/lib";
      EXTRA_CCFLAGS="-I/usr/include";
          };
        }
      );
}
