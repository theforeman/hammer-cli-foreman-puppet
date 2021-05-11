require 'hammer_cli_foreman/organization'
require 'hammer_cli_foreman_puppet/references'
require 'hammer_cli_foreman_puppet/command_extensions/organization'

module HammerCLIForemanPuppet
  class Organization < HammerCLIForemanPuppet::Command
    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      output do
        HammerCLIForemanPuppet::References.environments(self)
      end
    end
  end

  HammerCLIForeman::Organization::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Organization::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Organization::InfoCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::OrganizationInfo.new
  )

  #TODO: verify
  ::HammerCLIForeman::Organization.instance_eval do
    HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(self)
  end
end
