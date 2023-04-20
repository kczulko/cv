{
  description = "kczulko cv";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pname = "kczulko-cv";
        pkgs = import nixpkgs { inherit system; };
        secrets = import ./secrets.nix;
        secrectsAsList = with pkgs.lib;
          mapAttrsToList
            (name: value: ''!!!${name}!!! ${value}'')
            (mapAttrs (name: value: escapeShellArg value) secrets)
        ;
        patchScript = pkgs.lib.foldl
          (a: b: a + ''substituteInPlace ${pname}.tex --replace ${b}'' + "\n")
          ""
          secrectsAsList;

        kczulko-cv = pkgs.stdenv.mkDerivation
          {
            name = pname;

            src = ./src;

            postPatch = patchScript;

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
              lualatex -interaction=nonstopmode $name.tex
              lualatex -interaction=nonstopmode $name.tex
            '';

            installPhase = ''
              mkdir -p $out
              cp $name.log $out
              cp $name.pdf $out
            '';
          };

        show-cv = with pkgs; writeShellApplication {
          name = "showcv";
          text = ''${evince}/bin/evince ${kczulko-cv}/kczulko-cv.pdf'';
        };
      in
      {
        packages = { inherit kczulko-cv show-cv; }; 
        defaultPackage = kczulko-cv;
        devShell = pkgs.mkShell { buildInputs = [ show-cv ]; };
        formatter = pkgs.nixpkgs-fmt;
      });
}
