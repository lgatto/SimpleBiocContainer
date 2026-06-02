test_that(".ensureReleaseVersion works", {
    skip_if_offline()

    expect_error(.ensureReleaseVersion("error"), "invalid version")
    expect_error(.ensureReleaseVersion(c("3.22", "3.23")), "needs to have length one")
    expect_error(.ensureReleaseVersion("0.99"), "unknown Bioconductor version")
    expect_error(.ensureReleaseVersion(BiocManager:::.version_bioc("devel")),
                 "is not a former or current release version")

    expect_identical(.ensureReleaseVersion("3.18"), package_version("3.18"))
    expect_identical(.ensureReleaseVersion("3.20"), package_version("3.20"))
    expect_identical(.ensureReleaseVersion("3.22"), package_version("3.22"))
    expect_identical(.ensureReleaseVersion(package_version("3.22")), package_version("3.22"))
})

