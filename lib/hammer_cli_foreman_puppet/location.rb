require 'hammer_cli_foreman/location'
require 'hammer_cli_foreman_puppet/references'
require 'hammer_cli_foreman_puppet/command_extensions/location'

module HammerCLIForemanPuppet
  class Location < HammerCLIForeman::Command
    class InfoCommand < HammerCLIForeman::InfoCommand
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

  #TODO - verify
  ::HammerCLIForeman::Location.instance_eval do
    HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(self)
  end
end
