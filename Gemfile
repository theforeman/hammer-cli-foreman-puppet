source "https://rubygems.org"
dev_gemfile = File.expand_path("Gemfile.dev.rb", __dir__)
eval_gemfile(dev_gemfile) if File.exist?(dev_gemfile)
gemspec

gem 'gettext', '>= 3.1.3', '< 4.0.0'
gem 'hammer_cli_foreman', github: 'theforeman/hammer-cli-foreman', branch: 'master'

group :test do
  gem 'minitest'
  gem 'minitest-spec-context'
  gem 'mocha'
  gem 'rake', '~> 13.0'
  gem 'simplecov'
  gem 'theforeman-rubocop', '~> 0.1.0'
end

# load local gemfile
['Gemfile.local.rb', 'Gemfile.local'].map do |file_name|
  local_gemfile = File.join(File.dirname(__FILE__), file_name)
  instance_eval(Bundler.read_file(local_gemfile)) if File.exist?(local_gemfile)
end
