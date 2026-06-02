buildContainer <- function(dockerhub_tag) {
  buildargs <- paste0("build -t ", dockerhub_tag, " .")
  message("Building container.")
  system2("docker", args = buildargs)
}

pushToDockerHub <- function(dockerhub_tag){
  pushargs_hub <- paste0("push ", dockerhub_tag)
  message("Pushing container to Docker Hub.")
  system2("docker", args = pushargs_hub)
}

pushToGithub <- function(dockerhub_tag, ghcr_tag){
  tagargs <- paste0("tag ", dockerhub_tag, " ", ghcr_tag)
  message("Tagging for GitHub container registry️.")
  system2("docker", args = tagargs)
  pushargs_ghcr <- paste0("push ", ghcr_tag)
  message("Pushing container to GitHub container registry.")
  system2("docker", args = pushargs_ghcr)
}


pushDocker <- function(container, docker_username, gh_username = NULL) {
  oldpath <- getwd()
  on.exit(setwd(oldpath))
  
  image_name <- basename(container)
  dockerhub_tag <- paste0(docker_username, "/", image_name)
  setwd(container)
  
  buildContainer(dockerhub_tag)
  pushToDockerHub(dockerhub_tag)
  if (!is.null(gh_username)){
    ghcr_tag <- paste0("ghcr.io/", gh_username, "/", image_name)
    pushToGithub(dockerhub_tag, ghcr_tag)
  }  
  else{
    message("Skipped push to GitHub")
    ghcr_tag <- NULL
  }
  
  message("Pushing Happend")
  return(c(DockerHub = dockerhub_tag, GHCR = ghcr_tag))
}

