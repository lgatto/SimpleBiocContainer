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
- [`buildPushDocker()`](https://lgatto.github.io/SimpleBiocContainer/reference/buildPushDocker.md),
  which builds the created container and pushes it to Docker Hub.

Packages to include in the container are either the currently attached
packages (default) or specified by users. The files mentioned for
[`makeSimpleBiocContainer()`](https://lgatto.github.io/SimpleBiocContainer/reference/makeSimpleBiocContainer.md)
include datasets and scripts users may find useful to have in the
container.

## Quick start

We have one or multiple packages that we want to add to the container
and character vectors with data and scripts file names to be included.
We can create our container and name it `"my_container"` as follows:

``` r

file.create("data.rda")
```

    [1] TRUE

``` r

file.create("script.R")
```

    [1] TRUE

``` r

library(SimpleBiocContainer)
container_path <- makeSimpleBiocContainer(
  package = "MsCoreUtils",
  container = "my_container",
  data = "data.rda",
  script = "script.R")
```

    Creating the container directory 🪐.

    Creating the Dockerfile 🔔.

    Adding data.rda 📂

    Adding script.R 📂

    Done 👍.

``` r

container_path
```

    [1] "/home/runner/work/SimpleBiocContainer/SimpleBiocContainer/vignettes/my_container"

The code chunk above then creates our container, stores it in the
working directory, and stores the path to the container directory in
`container_path`. If `package` is not specified,
[`makeSimpleBiocContainer()`](https://lgatto.github.io/SimpleBiocContainer/reference/makeSimpleBiocContainer.md)
will store all the packages that are loaded in the current session.

After running `makeSimpleBiocConductor()`, we can build our container
and push it to Docker Hub as shown below:

``` r

buildPushDocker(
  container = container_path,
  dockerUsername = "docker_username") # replace by the intended Docker username
```

The argument `ghUsername` (`NULL` by default) allows us to push the
container to GitHub as well, being enough to feed it with a character
object that contains the username we intend to push the container to.

## Session information

``` r

sessionInfo()
```

    R version 4.6.0 (2026-04-24)
    Platform: x86_64-pc-linux-gnu
    Running under: Ubuntu 24.04.4 LTS

    Matrix products: default
    BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
    LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0

    locale:
     [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8
     [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8
     [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C
    [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C

    time zone: UTC
    tzcode source: system (glibc)

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base

    other attached packages:
    [1] SimpleBiocContainer_0.2.0

    loaded via a namespace (and not attached):
     [1] BiocManager_1.30.27 compiler_4.6.0      fastmap_1.2.0
     [4] cli_3.6.6           tools_4.6.0         htmltools_0.5.9
     [7] yaml_2.3.12         rmarkdown_2.31      knitr_1.51
    [10] jsonlite_2.0.0      xfun_0.58           digest_0.6.39
    [13] rlang_1.2.0         evaluate_1.0.5     
