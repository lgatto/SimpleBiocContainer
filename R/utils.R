#' Make sure a Bioconductor version is a release version
#'
#' We currently only support release versions of bioconductor.
#' To check existing versions, we use internal functionality from
#' \code{BiocManager}. If the provided version is a non-existent
#' or a devel/future version, the function will fail with an informative
#' error message.
#'
#' @param v Character scalar or \code{package_version} object with the desired
#'     Bioconductor version, typically returned by \code{BiocManager::version()}.
#'
#' @return A `character(1)` with the package version (if it is an existing
#'     release version).
#'
#' @import BiocManager
#'
#' @author Michael Stadler
#' @noRd
#' @keywords internal
.ensureReleaseVersion <- function(v) {
    # digest argument
    if (is.character(v)) {
        v <- package_version(v, strict = TRUE) # may fail for malformed `v`
    }
    if (length(v) != 1L) {
        stop("version needs to have length one")
    }

    # check against Bioconductor versions
    vmap <- BiocManager:::.version_map()
    i <- match(v, vmap$Bioc)

    if (is.na(i)) {
        stop("unknown Bioconductor version '", v, "'")
    }

    if (!vmap$BiocStatus[i] %in% c("release", "out-of-date")) {
        stop("version '", v, "' (", vmap$BiocStatus[i], ") is not a former or current release version")
    }

    # Remark: Should we check if a Bioconductor docker container exists?
    #         Can we do that without attempting to pull the image?

    return(as.character(v))
}

#' @title Add folders to the container
#'
#' @description This function adds the desired folder specified by the user
#'    to the container.
#'
#' @inheritParams makeSimpleBiocContainer
#'
#' @param folder A `character()` with the folder name(s) to include (along with 
#'    the contents) in the container.
#'    
#' @param df `character(1)` The Dockerfile to write to.
#' 
#' @param verbose Be verbose.
#'
#' @author Dania Machlab
#' @noRd
#' @keywords internal
.addFolderToContainer <- function(folder, container, df, verbose = TRUE) {
    # checks
    stopifnot(file.exists(df))
    stopifnot(!is.null(folder))

    # message if verbose
    if (verbose) {
        message("Adding ", paste(folder, collapse = ", "), " \U1F4C2")
    }

    # create and copy folder(s)
    for (f in folder) {
        dir.create(file.path(container, f))
        file.copy(f, file.path(container, f, "/"))
        cat("ADD ", f, " /home/rstudio/data/\n", file = df, append = TRUE)
    }
}
