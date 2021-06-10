module HammerCLIForemanPuppet
  module CommandExtensions
    class Host < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :location, HammerCLIForemanPuppet::Host::InfoCommand.output_definition.fields)
      end
    end
  end
end
