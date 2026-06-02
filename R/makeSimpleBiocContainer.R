#'
#'
#' @title makeSimpleBiocContainer
#' @description
#' This function creates a Dockerfile which will be used to create a container
#' with the desired \code{R} packages(s).
#' 
#' @param package The \code{R} package(s) to be included in the container.
#' @param container The name of the container.
#' @param data the data folder.
#' @param script the script folder.
#'
#'
#' @export
makeSimpleBiocContainer <- function(package = NULL,
                                    container = "mycontainer",
                                    data = NULL,
                                    script = NULL) {
    ## Check if files/dir are/is available/missing
    if (!is.null(data))
        if (!any(file.exists(data))) stop("Data not found.")
    if (!is.null(script))
        if (!any(file.exists(script))) stop("Script(s) not found.")
    if (file.exists(container))
        stop("Container directory already exists.")
    if (is.null(package))
        package <- unname(sapply(sessionInfo()$otherPkgs, \(x) x$Package))
    message("Creating the container directory 🪐.")
    dir.create(container)
    message("Creating the Dockerfile 🔔.")
    df <- file.path(container, "Dockerfile")
    stopifnot(file.create(df))
    v <- as.character(BiocManager::version())
    bioccontainer <- paste0("bioconductor/bioconductor_docker:RELEASE_", sub("\\.", "_", v))
    cat(paste("FROM ", bioccontainer, "\n"), file = df, append = TRUE)
    cat("RUN apt-get update && ",
        "apt-get install -y  cmake git libcurl4-openssl-dev libssl-dev libuv1-dev make pandoc && ",
        "rm -rf /var/lib/apt/lists/*\n",
        file = df, append = TRUE)
    cat("RUN mkdir -p /usr/local/lib/R/etc/ /usr/lib/R/etc/\n", file = df, append = TRUE)
    cat("RUN echo \"options(repos = c(BioCsoft = 'https://bioconductor.org/packages/", v, "/bioc',",
        "BioCann = 'https://bioconductor.org/packages/", v, "/data/annotation', ",
        "BioCexp = 'https://bioconductor.org/packages/", v, "/data/experiment', ",
        "CRAN = 'https://cloud.r-project.org'), download.file.method = 'libcurl', Ncpus = 4)\" | tee /usr/local/lib/R/etc/Rprofile.site | tee /usr/lib/R/etc/Rprofile.site\n",
        sep = "", file = df, append = TRUE)
    cat("RUN R -e 'options(warn = 2); install.packages(\"BiocManager\")'\n", file = df, append = TRUE)
    sapply(package, function(x) {
        cmd <- paste0("RUN Rscript -e 'BiocManager::install(\"", x, "\", update = FALSE, ask = FALSE)'\n")
        cat(cmd, file = df, append = TRUE)
    })
    if (!is.null(data)) {
        message("Adding data 📂.")
        dir.create(file.path(container, "data"))
        file.copy(data, paste0(container, "/data/"))
        cat("ADD data /home/rstudio/data/\n", file = df, append = TRUE)
    }
    if (!is.null(script)) {
        message("Adding scripts 🐶.")
        dir.create(file.path(container, "script"))
        file.copy(script, paste0(container, "/script/"))
        cat("ADD script /home/rstudio/script/\n", file = df, append = TRUE)
    }
    message("Done 👍")
    invisible(file.path(getwd(), container))
}
