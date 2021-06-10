module HammerCLIForemanPuppet
  module CommandExtensions
    class LocationInfo < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :realms, HammerCLIForemanPuppet::Location::InfoCommand.output_definition.fields)
      end
    end
  end
end
