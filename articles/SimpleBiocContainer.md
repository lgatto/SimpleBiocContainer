# Making simple Bioconductor containers

## Introduction

`SimpleBiocContainer` provides a simple, user-friendly way for users to
create R/Bioconductor containers with the convenient packages, datasets
and R scripts, as well as to share those containers with the community
through [Docker Hub](https://hub.docker.com) or the [GitHub container
registry](https://github.blog/news-insights/product-news/introducing-github-container-registry/).

Note that you must have installed [Docker](https://www.docker.com) on
your system to be able to execute `SimpleBiocContainer` functions. You
can download and install Docker Desktop
[here](https://www.docker.com/products/docker-desktop/).

## Functions

`SimpleBiocContainer` contains the following functions:

- [`makeSimpleBiocContainer()`](https://lgatto.github.io/SimpleBiocContainer/reference/makeSimpleBiocContainer.md),
  which creates a container directory and the respective files;
- `runDocker()`, which builds the created container and pushes it to
  Docker Hub.

Packages to include in the container are either the currently attached
packages (default) or specified by users. The files mentioned for
[`makeSimpleBiocContainer()`](https://lgatto.github.io/SimpleBiocContainer/reference/makeSimpleBiocContainer.md)
include datasets and scripts users may find useful to have in the
container.

## Quick start

assuming we have a character array `pacs` with the packages to store in
the container and character arrays `datasets` and `scripts` with the
paths to the data and the scripts respectively, to be included, we can
create our container and name it “my_container” as follows:

``` r

makeSimpleBiocContainer(
  package = pacs,
  container = "my_container",
  data = datasets,
  script = scripts
)
```

The code chunk above then creates our container, stores it in the
working directory, and returns a character object with the path to the
directory. If `package` is not specified,
[`makeSimpleBiocContainer()`](https://lgatto.github.io/SimpleBiocContainer/reference/makeSimpleBiocContainer.md)
will store all the packages that are loaded in the current session.
