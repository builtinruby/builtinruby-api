Octokit.configure do |config|
  config.access_token = ENV['OCTOKIT_TOKEN']

  config.connection_options = {
    request: {
      open_timeout: 5,
      timeout: 5,
    },
  }
end
