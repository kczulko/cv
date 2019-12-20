{ pkgs ? import (builtins.fetchTarball {
  name = "nixos-unstable-2019-12-05";
  url =  https://github.com/nixos/nixpkgs/archive/cc6cf0a96a627e678ffc996a8f9d1416200d6c81.tar.gz;
  sha256 = "1srjikizp8ip4h42x7kr4qf00lxcp1l8zp6h0r1ddfdyw8gv9001";
}) {} }: with pkgs;

  let
    name = "kczulko-cv";

    secrets = import ./secrets.nix;
    
    derivationParams = {
      name = name;

      src = ./src;

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
        lualatex -interaction=nonstopmode $src/$name.tex
      '';

      installPhase = ''
        mkdir -p $out
        cp $name.log $out
        cp $name.pdf $out
      '';
    };
  in
    stdenv.mkDerivation (derivationParams // secrets)
