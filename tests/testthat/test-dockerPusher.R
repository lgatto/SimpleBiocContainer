library(mockery)

test_that("buildPushDocker successfully calls all three build/push functions", {

  mock_build    <- mockery::mock()
  mock_push_hub <- mockery::mock()
  mock_push_gh  <- mockery::mock()

  mockery::stub(buildPushDocker, ".buildContainer", mock_build)
  mockery::stub(buildPushDocker, ".pushToDockerHub", mock_push_hub)
  mockery::stub(buildPushDocker, ".pushToGithub", mock_push_gh)

  temp_container <- tempdir()
  suppressMessages(buildPushDocker(temp_container, "random_docker_user", "random_gh_user"))

  mockery::expect_called(mock_build, 1)
  mockery::expect_called(mock_push_hub, 1)
  mockery::expect_called(mock_push_gh, 1)
})


test_that("buildPushDocker successfully calls 2 functions when github username is null", {

  mock_build    <- mockery::mock()
  mock_push_hub <- mockery::mock()
  mock_push_gh  <- mockery::mock()

  mockery::stub(buildPushDocker, ".buildContainer", mock_build)
  mockery::stub(buildPushDocker, ".pushToDockerHub", mock_push_hub)
  mockery::stub(buildPushDocker, ".pushToGithub", mock_push_gh)

  temp_container <- tempdir()
  suppressMessages(buildPushDocker(temp_container, "random_docker_user"))

  mockery::expect_called(mock_build, 1)
  mockery::expect_called(mock_push_hub, 1)
  mockery::expect_called(mock_push_gh, 0)
})
