require 'rake/testtask'
require 'ci/reporter/rake/minitest'

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.test_files = Dir.glob('test/**/*_test.rb')
  t.verbose = true
  t.warning = ENV.key?('RUBY_WARNINGS')
end

task :default => :test

require 'hammer_cli_foreman_puppet/version'
require 'hammer_cli_foreman_puppet/i18n'
require 'hammer_cli/i18n/find_task'
HammerCLI::I18n::FindTask.define(HammerCLIForemanPuppet::I18n::LocaleDomain.new,
                                 HammerCLIForemanPuppet.version)
