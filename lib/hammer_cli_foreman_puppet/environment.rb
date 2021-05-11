module HammerCLIForemanPuppet
  class PuppetEnvironment < HammerCLIForemanPuppet::Command
    resource :environments

    class ListCommand < HammerCLIForemanPuppet::ListCommand
      include EnvironmentNameMapping
      output do
        field :id, _('Id')
        field :name, _('Name')
      end

      build_options
    end

    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      include EnvironmentNameMapping
      output ListCommand.output_definition do
        HammerCLIForemanPuppet::PuppetReferences.puppetclasses(self)
        HammerCLIForeman::References.taxonomies(self)
        HammerCLIForeman::References.timestamps(self)
      end

      build_options
    end

    class CreateCommand < HammerCLIForemanPuppet::CreateCommand
      include EnvironmentNameMapping
      success_message _("Environment created.")
      failure_message _("Could not create the environment")

      build_options
    end

    class UpdateCommand < HammerCLIForemanPuppet::UpdateCommand
      include EnvironmentNameMapping
      success_message _("Environment updated.")
      failure_message _("Could not update the environment")

      build_options
    end

    class DeleteCommand < HammerCLIForemanPuppet::DeleteCommand
      include EnvironmentNameMapping
      success_message _("Environment deleted.")
      failure_message _("Could not delete the environment")

      build_options
    end

    class SCParamsCommand < HammerCLIForemanPuppet::SmartClassParametersList
      include EnvironmentNameMapping
      build_options_for :environments

      extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new)
    end

    autoload_subcommands
  end
end
