require 'hammer_cli_foreman/organization'

module HammerCLIForemanPuppet
  HammerCLIForeman::Organization::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Organization::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  #TODO: verify
  ::HammerCLIForeman::Organization.instance_eval do
    HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(self)
  end
end
