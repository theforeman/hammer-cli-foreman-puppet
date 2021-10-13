# frozen_string_literal: true
require 'hammer_cli_foreman/combination'
require 'hammer_cli_foreman_puppet/command_extensions/combination'

module HammerCLIForemanPuppet
  class Combination < HammerCLIForemanPuppet::Command
    class ListCommand < HammerCLIForemanPuppet::ListCommand
      output do
        field nil, _('Puppet Environment'), Fields::SingleReference, key: :environment
      end
    end

    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      include EnvironmentNameMapping
      output ListCommand.output_definition do
        field :environment_id, _('Puppet Environment ID')
        field :environment_name, _('Puppet Environment name')
      end
    end
  end

  HammerCLIForeman::Combination::ListCombination.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::ListCombination.new
  )
  HammerCLIForeman::Combination::InfoCombination.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::InfoCombination.new,
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Combination::UpdateCombination.include(HammerCLIForemanPuppet::EnvironmentNameMapping)
  HammerCLIForeman::Combination::UpdateCombination.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Combination::CreateCombination.include(HammerCLIForemanPuppet::EnvironmentNameMapping)
  HammerCLIForeman::Combination::CreateCombination.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
end
