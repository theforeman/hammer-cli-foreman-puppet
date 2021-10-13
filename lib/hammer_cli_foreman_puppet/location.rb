# frozen_string_literal: true

require 'hammer_cli_foreman/location'
require 'hammer_cli_foreman_puppet/command_extensions/location'

module HammerCLIForemanPuppet
  module LocationAddAssociatedCommand
    def self.included(base)
      HammerCLIForemanPuppet::AssociatingCommands::PuppetEnvironment.extend_command(base)
      base.create_subcommand
    end
  end

  class Location < HammerCLIForemanPuppet::Command
    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      output do
        HammerCLIForemanPuppet::PuppetReferences.environments(self)
      end
    end
  end

  HammerCLIForeman::Location::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Location::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironments.new
  )
  HammerCLIForeman::Location::InfoCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::LocationInfo.new
  )

  HammerCLIForeman::Location.class_eval do
    extend HammerCLIForemanPuppet::AssociatingCommands::ExtendCommands
    include HammerCLIForemanPuppet::LocationAddAssociatedCommand
  end
end
