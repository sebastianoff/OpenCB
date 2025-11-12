{
  description = "devenv";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # nix develop
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.pkg-config
          pkgs.stdenv.cc
        ];
        buildInputs = [
          pkgs.SDL
        ];
      };

      # nix build
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "OpenCB";
        version = "1.0.0-indev";
        src = ./.;

        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = [ pkgs.SDL ];

        installPhase = ''
          mkdir -p $out/bin
          install -m755 OpenCB $out/bin/OpenCB
        '';

        meta.mainProgram = "OpenCB";
      };
    };
}
