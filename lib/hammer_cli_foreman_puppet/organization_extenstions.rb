require 'hammer_cli_foreman/organization'

module HammerCLIForemanPuppet
  module OrganizationExtensions
    ::HammerCLIForeman::Organization::CreateCommand.instance_eval do
      extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new)
    end
    ::HammerCLIForeman::Organization::UpdateCommand.instance_eval do
      extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new)
    end
    ::HammerCLIForeman::Organization.instance_eval do
      HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(self)
    end
  end
end
