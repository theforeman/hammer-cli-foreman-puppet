# frozen_string_literal: true
require 'hammer_cli_foreman/organization'
require 'hammer_cli_foreman_puppet/command_extensions/organization'

module HammerCLIForemanPuppet
  module OrganizationAddAssociatedCommand
    def self.included(base)
      HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(base)
      base.create_subcommand
    end
  end

  class Organization < HammerCLIForemanPuppet::Command
    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      output do
        HammerCLIForemanPuppet::PuppetReferences.environments(self)
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

  HammerCLIForeman::Organization.class_eval do
    extend HammerCLIForemanPuppet::AssociatingCommands::ExtendCommands
    include HammerCLIForemanPuppet::OrganizationAddAssociatedCommand
  end
end
