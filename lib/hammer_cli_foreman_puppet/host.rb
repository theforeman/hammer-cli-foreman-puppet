require 'hammer_cli_foreman/host'
require 'hammer_cli_foreman_puppet/class'
require 'hammer_cli_foreman_puppet/host'
require 'hammer_cli_foreman_puppet/command_extensions/host'

module HammerCLIForemanPuppet
  class Host < HammerCLIForemanPuppet::Command
    class PuppetClassesCommand < HammerCLIForemanPuppet::ListCommand
      include EnvironmentNameMapping
      command_name 'puppet-classes'
      resource :puppetclasses

      output HammerCLIForemanPuppet::PuppetClass::ListCommand.output_definition

      def send_request
        HammerCLIForemanPuppet::PuppetClass::ListCommand.unhash_classes(super)
      end

      build_options do |o|
        o.without(:hostgroup_id, :environment_id)
        o.expand.only(:hosts)
      end
    end

    class SCParamsCommand < HammerCLIForemanPuppet::SmartClassParametersList
      build_options_for :hosts
      command_name 'sc-params'

      def validate_options
        super
        validator.any(:option_host_name, :option_host_id).required
      end
    end

    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      include EnvironmentNameMapping
      output do
        field nil, _('Puppet Environment'), Fields::SingleReference, key: :environment
        field nil, _('Puppet CA Proxy'), Fields::SingleReference, key: :puppet_ca_proxy
        field nil, _('Puppet Master Proxy'), Fields::SingleReference, key: :puppet_proxy
      end
    end
  end

  HammerCLIForeman::Host.subcommand 'puppet-classes',
    HammerCLIForemanPuppet::Host::PuppetClassesCommand.desc,
    HammerCLIForemanPuppet::Host::PuppetClassesCommand

  HammerCLIForeman::Host.subcommand 'sc-params',
    HammerCLIForemanPuppet::Host::SCParamsCommand.desc,
    HammerCLIForemanPuppet::Host::SCParamsCommand

  HammerCLIForeman::Host::ListCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Host::CreateCommand.include(HammerCLIForemanPuppet::EnvironmentNameMapping)
  HammerCLIForeman::Host::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new,
    HammerCLIForemanPuppet::CommandExtensions::HostPuppetProxy.new
  )
  HammerCLIForeman::Host::UpdateCommand.include(HammerCLIForemanPuppet::EnvironmentNameMapping)
  HammerCLIForeman::Host::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new,
    HammerCLIForemanPuppet::CommandExtensions::HostPuppetProxy.new
  )
  HammerCLIForeman::Host::InfoCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::Host.new
  )
end
