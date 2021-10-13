# frozen_string_literal: true

module HammerCLIForemanPuppet
  module CommandExtensions
    class ListCombination < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :hostgroup, HammerCLIForemanPuppet::Combination::ListCommand.output_definition.fields)
      end
    end

    class InfoCombination < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :hostgroup_name, HammerCLIForemanPuppet::Combination::InfoCommand.output_definition.fields)
      end
    end
  end
end
