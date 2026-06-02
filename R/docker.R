runDocker <- function(container, username) {
    oldpath <- getwd()
    on.exit(setwd(oldpath))
    containername <- paste0(username, "/", basename(container))
    setwd(container)
    buildargs <- paste0("build -t ", containername, " .")
    message("Building container \U1F3E0.")
    system2("docker", args = buildargs)
    pushargs <- paste0("push ", containername)
    message("Pushing container \U1F4CC.")
    system2("docker", args = pushargs)
    return(containername)
}
