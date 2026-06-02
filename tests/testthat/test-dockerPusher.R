library(mockery)

test_that("pushDocker successfully calls all three build/push functions", {

  mock_build    <- mockery::mock()
  mock_push_hub <- mockery::mock()
  mock_push_gh  <- mockery::mock()

  mockery::stub(pushDocker, "buildContainer", mock_build)
  mockery::stub(pushDocker, "pushToDockerHub", mock_push_hub)
  mockery::stub(pushDocker, "pushToGithub", mock_push_gh)

  temp_container <- tempdir()
  suppressMessages(pushDocker(temp_container, "random_docker_user", "random_gh_user"))

  mockery::expect_called(mock_build, 1)
  mockery::expect_called(mock_push_hub, 1)
  mockery::expect_called(mock_push_gh, 1)
})


test_that("pushDocker successfully calls 2 functions when github username is null", {
  
  mock_build    <- mockery::mock()
  mock_push_hub <- mockery::mock()
  mock_push_gh  <- mockery::mock()
  
  mockery::stub(pushDocker, "buildContainer", mock_build)
  mockery::stub(pushDocker, "pushToDockerHub", mock_push_hub)
  mockery::stub(pushDocker, "pushToGithub", mock_push_gh)
  
  temp_container <- tempdir()
  suppressMessages(pushDocker(temp_container, "random_docker_user"))
  
  mockery::expect_called(mock_build, 1)
  mockery::expect_called(mock_push_hub, 1)
  mockery::expect_called(mock_push_gh, 0)
})