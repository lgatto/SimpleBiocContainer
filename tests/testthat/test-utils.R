test_that(".ensureReleaseVersion works", {
    skip_if_offline()

    expect_error(.ensureReleaseVersion("error"), "invalid version")
    expect_error(.ensureReleaseVersion(c("3.22", "3.23")), "needs to have length one")
    expect_error(.ensureReleaseVersion("0.99"), "unknown Bioconductor version")
    expect_error(.ensureReleaseVersion(BiocManager:::.version_bioc("devel")),
                 "is not a former or current release version")

    expect_identical(.ensureReleaseVersion("3.18"), "3.18")
    expect_identical(.ensureReleaseVersion("3.20"), "3.20")
    expect_identical(.ensureReleaseVersion("3.22"), "3.22")
    expect_identical(.ensureReleaseVersion(package_version("3.22")), "3.22")
})

test_that(".getPackageInstallSources works", {

    expect_error(.getPackageInstallSources(1:3), "must be a character vector")

    skip_if_offline()
    res <- .getPackageInstallSources(c("edgeR", "MASS", "BiocManager",
                                       "something", "fmicompbio/monaLisa"))
    expect_identical(
        res,
        factor(c("repository", "repository", "repository", "unknown", "github"),
               levels = c("repository", "github", "unknown")))
})
