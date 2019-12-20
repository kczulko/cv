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
