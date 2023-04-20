# kczulko cv

## Secret data encryption

1. Secrets are stored within `secrets.nix` file, which has the following content:

```nix
{
  DATE_OF_BIRTH    = "January 1st 1900";
  CELLPHONE        = "999 999 999";
  ADDRESS_STREET   = "...";
  ADDRESS_ZIP_CITY = "...";
  ADDRESS_COUNTRY  = "...";
}
```

## BUILD

1. Build pdf document:

``` bash
$ nix build
```

1. Examine document with `evince`:

```
$ nix run .#show-cv
```

1. Nix files formatting:

```
$ nix fmt
```

1. Git crypt:

```
$ git-crypt unlock <your_symmetric.key>
```
