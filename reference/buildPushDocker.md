# Build and Push the Container

Simple function to build and push the container to Docker Hub or
optionally Github directly from R.

## Usage

``` r
buildPushDocker(container, dockerUsername, ghUsername = NULL)
```

## Arguments

- container:

  `character(1)` with the path to the container directory, as generated
  by
  [`makeSimpleBiocContainer()`](https://lgatto.github.io/SimpleBiocContainer/reference/makeSimpleBiocContainer.md).

- dockerUsername:

  `character(1)` container a Docker Hub username.

- ghUsername:

  `character(1)` container a GitHub username.

## Value

Returns the named vector of the Docker (and optional) GitHub containers
in the registries.

## Author

Ata Badr Barzegar and Laurent Gatto
