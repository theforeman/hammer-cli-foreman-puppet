lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hammer_cli_foreman_puppet/version'

Gem::Specification.new do |spec|
  spec.name          = 'hammer_cli_foreman_puppet'
  spec.version       = HammerCLIForemanPuppet.version.dup
  spec.authors       = ['Amir Fefer']
  spec.email         = ['amirfefer@gmail.com']
  spec.homepage      = 'https://github.com/theforeman/hammer-cli-foreman-puppet'
  spec.license       = 'GPL-3.0'

  spec.platform      = Gem::Platform::RUBY
  spec.summary       = 'Foreman Puppet plugin for Hammer CLI'

  # TODO: Don't forget to update required files accordingly!
  spec.files         = Dir['{lib,config}/**/*', 'LICENSE', 'README*']
  spec.require_paths = ['lib']
  spec.test_files    = Dir['{test}/**/*']

  spec.add_dependency 'hammer_cli_foreman', '>= 2.0.0', '< 3.0.0'
end
