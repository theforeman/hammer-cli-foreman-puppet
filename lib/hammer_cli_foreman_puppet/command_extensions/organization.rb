module HammerCLIForemanPuppet
  module CommandExtensions
    class OrganizationInfo < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :realms, HammerCLIForemanPuppet::Organization::InfoCommand.output_definition.fields)
      end
    end
  end
end
