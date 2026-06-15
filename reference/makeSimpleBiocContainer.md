# Create a Simple Bioconductor Container

This function is the main working horse the the package. It creates a
container directory and populates it with a Dockerfile and optional data
and script directories. The container is ready to be build, pushed and
shared with collaborators.

## Usage

``` r
makeSimpleBiocContainer(
  package = NULL,
  container = "mycontainer",
  data = NULL,
  script = NULL
)
```

## Arguments

- package:

  An optional vector of package names. If not provided, the currently
  attached packages are used. The function will verify that all the
  attached packages can be installed from CRAN or Bioconductor and fail
  otherwise.

- container:

  `character(1)` with the name of the container. This name will be used
  to create the directory for the Docker file and optional data and
  script directories.

- data:

  Optional [`character()`](https://rdrr.io/r/base/character.html) with
  the path to one or multiple data files to be included in the container
  in `/home/rstudio/data/`. Missing files will lead to errors.

- script:

  Optional [`character()`](https://rdrr.io/r/base/character.html) with
  the path to one or multiple scripts to be included in the container in
  `/home/rstudio/script/`. Missing files will lead to errors.

## Value

The function returns a `character(1)` with the path to the container
directory. It is used for its side effect of creating and populating the
directory. See
[`buildPushDocker()`](https://lgatto.github.io/SimpleBiocContainer/reference/buildPushDocker.md)
to build and push the container.

## Author

SimpleBiocContainer authors

## Examples

``` r

## Run this in a temporary directory
oldwd <- getwd()
setwd(tempdir())
file.create("data.txt")
#> [1] TRUE
makeSimpleBiocContainer(package = "BiocVersion",
                        data = "data.txt")
#> Creating the container directory 🪐.
#> Creating the Dockerfile 🔔.
#> Adding data.txt 📂
#> Done 👍.
#> [1] "/tmp/RtmptrbAcP/mycontainer"
setwd(oldwd)
```
