source "https://rubygems.org"
dev_gemfile = File.expand_path("Gemfile.dev.rb", __dir__)
eval_gemfile(dev_gemfile) if File.exist?(dev_gemfile)
gemspec

group :test do
  gem 'ci_reporter', '>= 1.6.3', '< 2.0.0', :require => false
  gem 'minitest'
  gem 'minitest-spec-context'
  gem 'mocha'
  gem 'rake', '~> 13.0'
  gem 'simplecov'
end

# load local gemfile
['Gemfile.local.rb', 'Gemfile.local'].map do |file_name|
  local_gemfile = File.join(File.dirname(__FILE__), file_name)
  self.instance_eval(Bundler.read_file(local_gemfile)) if File.exist?(local_gemfile)
end
