module HammerCLIForemanPuppet
  module AssociatingCommands
    module PuppetEnvironment
      extend HammerCLIForeman::AssociatingCommands::CommandExtension

      class AddPuppetEnvironmentCommand < HammerCLIForeman::AddAssociatedCommand
        associated_resource :environments
        desc _('Associate a Puppet environment')
        command_name "add-environment"

        success_message _("The environment has been associated.")
        failure_message _("Could not associate the environment")

        extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new)
      end

      class RemovePuppetEnvironmentCommand < HammerCLIForeman::RemoveAssociatedCommand
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
