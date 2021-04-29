module HammerCLIForemanPuppet
  require 'hammer_cli'
  require 'hammer_cli_foreman'

  require 'hammer_cli_foreman_puppet/version'
  require 'hammer_cli_foreman_puppet/puppet_references'
  require 'hammer_cli_foreman_puppet/command_extensions'
  require 'hammer_cli_foreman_puppet/option_sources'
  require 'hammer_cli_foreman_puppet/associating_commands'

  require 'hammer_cli_foreman_puppet/organization_extenstions'
  require 'hammer_cli_foreman_puppet/location_extenstions'

  require 'hammer_cli_foreman_puppet/classes'
  require 'hammer_cli_foreman_puppet/environment'
  require 'hammer_cli_foreman_puppet/config_group'
  require 'hammer_cli_foreman_puppet/smart_class_parameter'


  HammerCLI::MainCommand.lazy_subcommand(
    'classes',
    _('Manage Foreman Puppet Classes'),
    'HammerCLIForemanPuppet::PuppetClass',
    'hammer_cli_foreman_puppet/class'
  )
  HammerCLI::MainCommand.lazy_subcommand(
    'environment',
    _('Manage Foreman puppet environments'),
    'HammerCLIForemanPuppet::PuppetEnvironment',
    'hammer_cli_foreman_puppet/environment'
  )
  HammerCLI::MainCommand.lazy_subcommand(
    'config-group',
    _('Manage Foreman config groups'),
    'HammerCLIForemanPuppet::ConfigGroup',
    'hammer_cli_foreman_puppet/config_group'
  )
  HammerCLI::MainCommand.lazy_subcommand(
    'smart-class-paramaters',
    _('Manage Foreman puppet smart class paramteters'),
    'HammerCLIForemanPuppet::SmartClassParameter',
    'hammer_cli_foreman_puppet/smart_class_parameter'
  )
  # subcommands to hammer_cli_foreman commands
  require 'hammer_cli_foreman_puppet/host'
  require 'hammer_cli_foreman_puppet/organization'
  require 'hammer_cli_foreman_puppet/location'
  require 'hammer_cli_foreman_puppet/smart_proxy'
  require 'hammer_cli_foreman_puppet/combination'
  require 'hammer_cli_foreman_puppet/hostgroup'
end

