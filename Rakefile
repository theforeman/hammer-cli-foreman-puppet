require 'rake/testtask'
require 'ci/reporter/rake/minitest'

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.test_files = Dir.glob('test/**/*_test.rb')
  t.verbose = true
end

task :default do
  Rake::Task['test'].execute
end
