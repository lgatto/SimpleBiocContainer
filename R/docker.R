runDocker <- function(container, username) {
    oldpath <- getwd()
    on.exit(setwd(oldpath))
    containername <- paste0(username, "/", basename(container))
    setwd(container)
    buildargs <- paste0("build -t ", containername, " .")
    message("Building container 🏠.")
    system2("docker", args = buildargs)
    pushargs <- paste0("push ", containername)
    message("Pushing container 📌.")
    system2("docker", args = pushargs)
    return(containername)
}
