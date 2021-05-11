require 'hammer_cli_foreman/location'
require 'hammer_cli_foreman_puppet/references'
require 'hammer_cli_foreman_puppet/command_extensions/location'

module HammerCLIForemanPuppet
  class Location < HammerCLIForemanPuppet::Command
    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      include EnvironmentNameMapping
      output do
        HammerCLIForemanPuppet::References.environments(self)
      end
    end
  end

  HammerCLIForeman::Location::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Location::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Location::InfoCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::LocationInfo.new
  )

  ::HammerCLIForeman::Location.instance_eval do
    HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(self)
  end
end
