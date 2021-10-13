require 'hammer_cli_foreman/hostgroup'
require 'hammer_cli_foreman_puppet/command_extensions/hostgroup'

module HammerCLIForemanPuppet
  class Hostgroup < HammerCLIForemanPuppet::Command
    class PuppetClassesCommand < HammerCLIForemanPuppet::ListCommand
      command_name 'puppet-classes'
      resource :puppetclasses

      output HammerCLIForemanPuppet::PuppetClass::ListCommand.output_definition

      def send_request
        HammerCLIForemanPuppet::PuppetClass::ListCommand.unhash_classes(super)
      end

      build_options do |o|
        o.without(:host_id, :environment_id)
        o.expand.only(:hostgroups)
      end
    end

    class PuppetSCParamsCommand < HammerCLIForemanPuppet::SmartClassParametersList
      build_options_for :hostgroups
      command_name 'sc-params'

      def validate_options
        super
        validator.any(:option_hostgroup_name, :option_hostgroup_id).required
      end
    end

    class ListCommand < HammerCLIForemanPuppet::InfoCommand
      output do
        field nil, _('Puppet Environment'), Fields::SingleReference, key: :environment
      end
    end

    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      output do
        field nil, _('Puppet Environment'), Fields::SingleReference, key: :environment
        field nil, _('Puppet CA Proxy'), Fields::SingleReference, key: :puppet_ca_proxy
        field nil, _('Puppet Master Proxy'), Fields::SingleReference, key: :puppet_proxy
        HammerCLIForemanPuppet::PuppetReferences.puppetclasses(self)
      end
    end
  end

  HammerCLIForeman::Hostgroup.subcommand 'puppet-classes',
    HammerCLIForemanPuppet::Hostgroup::PuppetClassesCommand.desc,
    HammerCLIForemanPuppet::Hostgroup::PuppetClassesCommand

  HammerCLIForeman::Hostgroup.subcommand 'sc-params',
    HammerCLIForemanPuppet::Hostgroup::PuppetSCParamsCommand.desc,
    HammerCLIForemanPuppet::Hostgroup::PuppetSCParamsCommand

  HammerCLIForeman::Hostgroup::CreateCommand.include(HammerCLIForemanPuppet::EnvironmentNameMapping)
  HammerCLIForeman::Hostgroup::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new,
    HammerCLIForemanPuppet::CommandExtensions::HostgroupPuppetProxy.new
  )
  HammerCLIForeman::Hostgroup::UpdateCommand.include(HammerCLIForemanPuppet::EnvironmentNameMapping)
  HammerCLIForeman::Hostgroup::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new,
    HammerCLIForemanPuppet::CommandExtensions::HostgroupPuppetProxy.new
  )
  HammerCLIForeman::Hostgroup::InfoCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::HostgroupInfo.new
  )
  HammerCLIForeman::Hostgroup::ListCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::HostgroupList.new
  )
  # TODO: - adding puppet class options
  # TODO - resolver
end
