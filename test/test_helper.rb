begin
  require 'simplecov'
rescue LoadError
else
  SimpleCov.use_merging true
  SimpleCov.start do
    command_name 'MiniTest'
    add_filter 'test'
  end
  SimpleCov.root(Pathname.new(__dir__) + "..")
end

require 'minitest/autorun'
require 'minitest/spec'
require "minitest-spec-context"
require "mocha/minitest"

require 'hammer_cli'
require 'hammer_cli/testing/command_assertions'
require 'hammer_cli_foreman/testing/api_expectations'
FOREMAN_VERSION = Gem::Version.new(ENV['TEST_API_VERSION'] || '3.0')

include HammerCLI::Testing::CommandAssertions
include HammerCLIForeman::Testing::APIExpectations
HammerCLI.context[:api_connection].create('foreman') do
  api_connection({}, FOREMAN_VERSION)
end

require 'hammer_cli_foreman'
require 'hammer_cli_foreman_puppet'
