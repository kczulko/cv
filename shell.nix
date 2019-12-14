{ pkgs ? import <nixpkgs> {} }: with pkgs;

  mkShell {
    FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ libertine ]; };
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
          cv4tw;
      })
    ];
  }
