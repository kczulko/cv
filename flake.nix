{
  description = "kczulko cv";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    # nixpkgs = {
      # url = "https://github.com/nixos/nixpkgs/archive/cc6cf0a96a627e678ffc996a8f9d1416200d6c81.tar.gz";
      # flake = false;
    # };
    # secrets.url = "./secrets.nix";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pname = "kczulko-cv";

        pkgs = nixpkgs.legacyPackages.${system};

        lib = pkgs.lib;

        secrets = import ./secrets.nix;

        secrectsAsList = lib.mapAttrsToList (name: value: ''!!!${name}!!! ${value}'') (lib.mapAttrs (name: value: lib.escapeShellArg value) secrets);

        patchScript = lib.foldl (a: b: a + ''substituteInPlace ${pname}.tex --replace ${b}'' + "\n") "" secrectsAsList;

        derivationParams = {
          name = pname;

          src = ./src;

          # postPatch = patchScript;

          buildInputs = with pkgs; [
            (texlive.combine {
              inherit (texlive)
                scheme-medium
                newenviron
                catoptions
                catchfile
                xstring
                lastpage
                libertine
                mweights
                fontaxes
                pbox
                needspace
                fontawesome
                realboxes
                forloop
                collectbox
                cv4tw;
            })
            glibcLocales
          ];

      buildPhase = ''
        export TEXMFVAR=$(pwd)
        lualatex -interaction=nonstopmode $src/$name.tex
        lualatex -interaction=nonstopmode $src/$name.tex
      '';

      installPhase = ''
        mkdir -p $out
        cp $name.log $out
        cp $name.pdf $out
      '';
    };
      in {
        packages.${pname} = pkgs.stdenv.mkDerivation (derivationParams // secrets);
        defaultPackage = self.packages.${system}.${pname};
        devShell = pkgs.mkShell { buildInputs = derivationParams.buildInputs; };
      });
}
