require 'hammer_cli_foreman/location'

module HammerCLIForemanPuppet
  HammerCLIForeman::Location::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Location::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  #TODO - verify
  ::HammerCLIForeman::Location.instance_eval do
    HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(self)
  end
end
