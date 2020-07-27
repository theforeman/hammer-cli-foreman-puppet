require 'hammer_cli_foreman/location'

module HammerCLIForemanPuppet
  module LocationExtensions
    ::HammerCLIForeman::Location::CreateCommand.instance_eval do
      extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new)
    end
    ::HammerCLIForeman::Location::UpdateCommand.instance_eval do
      extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new)
    end
    ::HammerCLIForeman::Location.instance_eval do
      HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(self)
    end
  end
end
