# frozen_string_literal: true
if ENV['CODECLIMATE_REPO_TOKEN']
  # require 'codeclimate-test-reporter'
  # CodeClimate::TestReporter.start
  require 'simplecov'
  SimpleCov.start
end

require 'bundler/setup'
Bundler.setup

require 'freshdesk_apiclient'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with(:rspec) {|c| c.syntax = :expect }
  config.mock_with(:rspec) {|mocks| mocks.verify_partial_doubles = true }
  # config.filter_run_including :focus => true
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.warnings = true

  Kernel.srand config.seed
end
