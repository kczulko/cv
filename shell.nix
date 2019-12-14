{ pkgs ? import <nixpkgs> {} }: with pkgs;

  mkShell {
    LANG= "en_US.UTF-8";
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
          collectbox
          cv4tw;
      })
      glibcLocales
    ];
  }
