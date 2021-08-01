module HammerCLIForemanPuppet
  class ConfigGroup < HammerCLIForemanPuppet::Command
    resource :config_groups

    class ListCommand < HammerCLIForemanPuppet::ListCommand
      output do
        field :id, _('ID')
        field :name, _('Name')
      end

      build_options
    end

    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      output ListCommand.output_definition do
        HammerCLIForemanPuppet::PuppetReferences.puppetclasses(self)
      end

      build_options
    end

    class CreateCommand < HammerCLIForemanPuppet::CreateCommand
      success_message _('Config group created.')
      failure_message _('Could not create the config group')

      build_options
    end

    class UpdateCommand < HammerCLIForemanPuppet::UpdateCommand
      success_message _('Config group updated.')
      failure_message _('Could not update the config group')

      build_options
    end

    class DeleteCommand < HammerCLIForemanPuppet::DeleteCommand
      success_message _('Config group has been deleted.')
      failure_message _('Could not delete the config group')

      build_options
    end

    autoload_subcommands
  end
end
