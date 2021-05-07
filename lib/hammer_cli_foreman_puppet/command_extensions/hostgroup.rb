module HammerCLIForemanPuppet
  module CommandExtensions
    class HostgroupInfo < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :compute_resource, HammerCLIForemanPuppet::Hostgroup::InfoCommand.output_definition.fields)
      end
    end

    class HostgroupList < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :operatingsystem, HammerCLIForemanPuppet::Hostgroup::ListCommand.output_definition.fields)
      end
    end
  end
end
