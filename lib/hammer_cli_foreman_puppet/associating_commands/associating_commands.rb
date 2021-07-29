module HammerCLIForemanPuppet
  module AssociatingCommands
    module ExtendCommands
      def create_subcommand(name = :PuppetEnvironment)
        commands = constants.select { |c| c.to_s.include? name.to_s }.map { |p| const_get(p)}
        commands.each do |command|
          subcommand(command.command_name, command.desc, command, warning: command.warning)
        end
      end
    end

    module PuppetEnvironment
      extend HammerCLIForeman::AssociatingCommands::CommandExtension

      class AddPuppetEnvironmentCommand < HammerCLIForemanPuppet::AddAssociatedCommand
        include EnvironmentNameMapping
        associated_resource :environments
        desc _('Associate a Puppet environment')
        command_name "add-environment"

        success_message _("The environment has been associated.")
        failure_message _("Could not associate the environment")

        extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new)
      end

      class RemovePuppetEnvironmentCommand < HammerCLIForemanPuppet::RemoveAssociatedCommand
        include EnvironmentNameMapping
        associated_resource :environments
        desc _('Disassociate a Puppet environment')
        command_name "remove-environment"

        success_message _("The environment has been disassociated.")
        failure_message _("Could not disassociate the environment")

        extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new)
      end
    end
  end
end
