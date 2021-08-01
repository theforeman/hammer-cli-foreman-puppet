require 'hammer_cli_foreman_discovery/discovery'
require 'hammer_cli_foreman_puppet/command_extensions/discovery'

module HammerCLIForemanPuppet
  HammerCLIForemanDiscovery::DiscoveredHost::ProvisionCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::Provision.new
  )
  HammerCLIForemanDiscovery::DiscoveredHost::ProvisionCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
end
