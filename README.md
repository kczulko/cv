# kczulko cv

## Secret data encryption

1. Install git-crypt - I store my secret data within `secrets.nix` which has following content:

``` nix
{
  DATE_OF_BIRTH    = "January 1st 1900";
  CELLPHONE        = "999 999 999";
  ADDRESS_STREET   = "...";
  ADDRESS_ZIP_CITY = "...";
  ADDRESS_COUNTRY  = "...";
}

```

2. Import symmetric key for this repository:

``` bash
git-crypt unlock your_symmetric.key
```

## BUILD

Execute:

```bash
nix-build
```

or

```
nix-build --arg secrets "{ DATE_OF_BIRTH = \"January 1st 1970\"; CELLPHONE = \"+48 000 000 000\"; ADDRESS_STREET = \"Wiejska 4\"; ADDRESS_ZIP_CITY = \"00-000 Gdańsk\"; ADDRESS_COUNTRY  = \"Poland\"; }" https://www.github.com/kczulko/cv/tarball/master
```
