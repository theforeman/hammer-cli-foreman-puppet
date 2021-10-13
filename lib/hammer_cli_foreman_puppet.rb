# frozen_string_literal: true

module HammerCLIForemanPuppet
  require 'hammer_cli'
  require 'hammer_cli/logger'
  require 'hammer_cli_foreman'

  require 'hammer_cli_foreman_puppet/version'
  require 'hammer_cli_foreman_puppet/puppet_references'
  require 'hammer_cli_foreman_puppet/environment_name_mapping'
  require 'hammer_cli_foreman_puppet/commands'
  require 'hammer_cli_foreman_puppet/command_extensions'
  require 'hammer_cli_foreman_puppet/option_sources'
  require 'hammer_cli_foreman_puppet/associating_commands'
  require 'hammer_cli_foreman_puppet/id_resolver'

  # Puppet commands
  require 'hammer_cli_foreman_puppet/smart_class_parameter'
  require 'hammer_cli_foreman_puppet/environment'
  require 'hammer_cli_foreman_puppet/config_group'
  require 'hammer_cli_foreman_puppet/class'

  # extensions to hammer_cli_foreman commands
  require 'hammer_cli_foreman_puppet/host'
  require 'hammer_cli_foreman_puppet/organization'
  require 'hammer_cli_foreman_puppet/location'
  require 'hammer_cli_foreman_puppet/smart_proxy'
  require 'hammer_cli_foreman_puppet/combination'
  require 'hammer_cli_foreman_puppet/hostgroup'

  HammerCLI::MainCommand.lazy_subcommand(
    'puppet-class',
    _('Manage Foreman Puppet classes'),
    'HammerCLIForemanPuppet::PuppetClass',
    'hammer_cli_foreman_puppet/class'
  )
  HammerCLI::MainCommand.lazy_subcommand(
    'puppet-environment',
    _('Manage Foreman Puppet environments'),
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
    'sc-param',
    _('Manage Foreman Puppet smart class parameters'),
    'HammerCLIForemanPuppet::SmartClassParameter',
    'hammer_cli_foreman_puppet/smart_class_parameter'
  )

  # Plugins extensions
  begin
    require 'hammer_cli_foreman_puppet/discovery'
  rescue Exception => e
    logger = Logging.logger['HammerCLIForemanPuppet::Discovery']
    logger.debug("Discovery plugin was not found: #{e}")
  end
end
