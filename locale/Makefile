DOMAIN = hammer-cli-foreman-puppet
VERSION = $(shell bundle exec ruby -C ../ -e 'require "rubygems"; spec = Gem::Specification::load("../hammer_cli_foreman_puppet.gemspec"); puts spec.version')
MAIN_MAKEFILE = $(shell bundle exec ruby -C ../ -e 'require "hammer_cli"; puts HammerCLI::I18n.main_makefile')

include $(MAIN_MAKEFILE)
