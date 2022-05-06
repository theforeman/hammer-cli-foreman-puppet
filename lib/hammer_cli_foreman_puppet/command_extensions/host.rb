module HammerCLIForemanPuppet
  module CommandExtensions
    class Host < HammerCLI::CommandExtensions
      output do |definition|
        definition.insert(:after, :location, HammerCLIForemanPuppet::Host::InfoCommand.output_definition.fields)
      end
    end

    class HostPuppetProxy < HammerCLI::CommandExtensions
      option_family(
        format: HammerCLI::Options::Normalizers::List.new,
        aliased_resource: 'puppet-class',
        description: 'Names/Ids of associated Puppet classes'
      ) do
        parent '--puppet-class-ids', 'PUPPET_CLASS_IDS', _('List of Puppet class ids'),
               attribute_name: :option_puppetclass_ids
        child '--puppet-classes', 'PUPPET_CLASS_NAMES', '',
              attribute_name: :option_puppetclass_names
      end
      option_family(
        format: HammerCLI::Options::Normalizers::List.new,
        aliased_resource: 'config_group',
        description: 'Names/Ids of associated config groups'
      ) do
        parent '--config-group-ids', 'CONFIG_GROUP_IDS', _('IDs of associated config groups'),
               attribute_name: :option_config_group_ids
        child '--config-groups', 'CONFIG_GROUP_NAMES', '',
              attribute_name: :option_config_group_names
      end
      option_family associate: 'puppet_proxy' do
        child '--puppet-proxy', 'PUPPET_PROXY_NAME', _('Name of Puppet proxy')
      end
      option_family associate: 'puppet_ca_proxy' do
        child '--puppet-ca-proxy', 'PUPPET_CA_PROXY_NAME', _('Name of Puppet CA proxy')
      end

      request_params do |params, command_object|
        if command_object.option_puppet_proxy
          params['host']['puppet_proxy_id'] ||= HammerCLIForemanPuppet::CommandExtensions::HostPuppetProxy.proxy_id(
            command_object.resolver, command_object.option_puppet_proxy
          )
        end
        if command_object.option_puppet_ca_proxy
          params['host']['puppet_ca_proxy_id'] ||= HammerCLIForemanPuppet::CommandExtensions::HostPuppetProxy.proxy_id(
            command_object.resolver, command_object.option_puppet_ca_proxy
          )
        end
      end

      def self.proxy_id(resolver, name)
        resolver.smart_proxy_id('option_name' => name)
      end

      def self.delete_deprecated_options(command_class)
        %w[--puppetclass-ids --environment-id --config-group-ids].each do |switch|
          family = command_class.option_families.find do |f|
            f.head.switches.include?(switch)
          end
          command_class.declared_options.delete_if do |o|
            family.all.include?(o)
          end
        end
      end
    end
  end
end
