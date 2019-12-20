{ pkgs ? import (builtins.fetchTarball {
  name = "nixos-unstable-2019-12-05";
  url =  https://github.com/nixos/nixpkgs/archive/cc6cf0a96a627e678ffc996a8f9d1416200d6c81.tar.gz;
  sha256 = "1srjikizp8ip4h42x7kr4qf00lxcp1l8zp6h0r1ddfdyw8gv9001";
}) {} }: with pkgs;

  let
    secrets = import ./secrets.nix;
  in
    stdenv.mkDerivation {
      name = "kczulko-cv";
      src = ./content;
      buildInputs = [
        (texlive.combine {
          inherit (texlive)
            scheme-medium
            newenviron
            catoptions
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
        lualatex -interaction=nonstopmode $src/kczulko-cv.tex
      '';

      installPhase = ''
        mkdir -p $out
        cp kczulko-cv.log $out
        cp kczulko-cv.pdf $out
      '';
    } // secrets
