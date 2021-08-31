require 'hammer_cli_foreman_discovery/discovery'
require 'hammer_cli_foreman_puppet/command_extensions/discovery'
require 'hammer_cli_foreman_puppet/command_extensions/environment'

module HammerCLIForemanPuppet
  HammerCLIForemanDiscovery::DiscoveredHost::ProvisionCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::Provision.new,
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
end
