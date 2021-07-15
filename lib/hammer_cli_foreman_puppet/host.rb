require 'hammer_cli_foreman/host'
require 'hammer_cli_foreman_puppet/class'
require 'hammer_cli_foreman_puppet/host'
require 'hammer_cli_foreman_puppet/command_extensions/host'

module HammerCLIForemanPuppet

  module CommonUpdateOptions
    def self.included(base)
      base.option '--puppet-proxy', 'PUPPET_PROXY_NAME', '',
                  referenced_resource: 'puppet_proxy',
                  aliased_resource: 'puppet_proxy'
      base.option '--puppet-ca-proxy', 'PUPPET_CA_PROXY_NAME', '',
                  referenced_resource: 'puppet_ca_proxy',
                  aliased_resource: 'puppet_ca_proxy'
      base.option_family(
        format: HammerCLI::Options::Normalizers::List.new,
        aliased_resource: 'puppet-class',
        description: 'Names/Ids of associated puppet classes'
      ) do
        parent '--puppet-class-ids', 'PUPPET_CLASS_IDS', '',
               attribute_name: :option_puppetclass_ids
        child '--puppet-classes', 'PUPPET_CLASS_NAMES', '',
               attribute_name: :option_puppetclass_names
      end
      base.build_options :without => [
           :puppet_class_ids]
    end

    def request_params
      puppet_proxy_id = proxy_id(option_puppet_proxy)
      params['host']['puppet_proxy_id'] ||= puppet_proxy_id unless puppet_proxy_id.nil?

      puppet_ca_proxy_id = proxy_id(option_puppet_ca_proxy)
      params['host']['puppet_ca_proxy_id'] ||= puppet_ca_proxy_id unless puppet_ca_proxy_id.nil?
    end
  end

  class Host < HammerCLIForeman::Command

    class PuppetClassesCommand < HammerCLIForeman::ListCommand
      command_name "puppet-classes"
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
      command_name "sc-params"

      def validate_options
        super
        validator.any(:option_host_name, :option_host_id).required
      end
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output do
        field nil, _("Puppet Environment"), Fields::SingleReference, :key => :environment
        field nil, _("Puppet CA Proxy"), Fields::SingleReference, :key => :puppet_ca_proxy
        field nil, _("Puppet Master Proxy"), Fields::SingleReference, :key => :puppet_proxy
      end
    end
  end

  ::HammerCLIForeman::Host::CreateCommand.instance_eval do
    include HammerCLIForemanPuppet::CommonUpdateOptions
  end

  ::HammerCLIForeman::Host::UpdateCommand.instance_eval do
    include HammerCLIForemanPuppet::CommonUpdateOptions
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
  HammerCLIForeman::Host::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Host::InfoCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::Host.new
  )
end
