require 'hammer_cli_foreman/hostgroup'
require 'hammer_cli_foreman_puppet/references'
require 'hammer_cli_foreman_puppet/command_extensions/hostgroup.rb'

module HammerCLIForemanPuppet

  module HostgroupUpdateCreatePuppetOptions
    def self.included(base)
      base.option "--puppet-class-ids", "PUPPETCLASS_IDS", _("List of puppetclass ids"),
        :format => HammerCLI::Options::Normalizers::List.new,
        :attribute_name => :option_puppetclass_ids
      base.option "--puppet-classes", "PUPPET_CLASS_NAMES", "",
        :format => HammerCLI::Options::Normalizers::List.new,
        :attribute_name => :option_puppetclass_names
      base.option "--puppet-ca-proxy", "PUPPET_CA_PROXY_NAME", _("Name of puppet CA proxy")
      base.option "--puppet-proxy", "PUPPET_PROXY_NAME",  _("Name of puppet proxy")
    end

    def request_params
      params['hostgroup']["puppet_proxy_id"] ||= proxy_id(option_puppet_proxy) if option_puppet_proxy
      params['hostgroup']["puppet_ca_proxy_id"] ||= proxy_id(option_puppet_ca_proxy) if option_puppet_ca_proxy
    end
  end

  class Hostgroup < HammerCLIForemanPuppet::Command

    class PuppetClassesCommand < HammerCLIForemanPuppet::ListCommand
      command_name "puppet-classes"
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
      command_name "sc-params"

      def validate_options
        super
        validator.any(:option_hostgroup_name, :option_hostgroup_id).required
      end
    end

    class ListCommand < HammerCLIForemanPuppet::InfoCommand
      output do
        field nil, _("Puppet Environment"), Fields::SingleReference, :key => :environment
      end
    end

    class InfoCommand < HammerCLIForemanPuppet::InfoCommand
      output do
        field nil, _("Puppet Environment"), Fields::SingleReference, :key => :environment
        field nil, _("Puppet CA Proxy"), Fields::SingleReference, :key => :puppet_ca_proxy
        field nil, _("Puppet Master Proxy"), Fields::SingleReference, :key => :puppet_proxy
        HammerCLIForemanPuppet::References.puppetclasses(self)
      end
    end
  end

  ::HammerCLIForeman::Hostgroup::CreateCommand.instance_eval do
    include HammerCLIForemanPuppet::HostgroupUpdateCreatePuppetOptions
  end
  ::HammerCLIForeman::Hostgroup::UpdateCommand.instance_eval do
    include HammerCLIForemanPuppet::HostgroupUpdateCreatePuppetOptions
  end

  HammerCLIForeman::Hostgroup.subcommand 'puppet-classes',
                                          HammerCLIForemanPuppet::Hostgroup::PuppetClassesCommand.desc,
                                          HammerCLIForemanPuppet::Hostgroup::PuppetClassesCommand

  HammerCLIForeman::Hostgroup.subcommand 'sc-params',
                                          HammerCLIForemanPuppet::Hostgroup::PuppetSCParamsCommand.desc,
                                          HammerCLIForemanPuppet::Hostgroup::PuppetSCParamsCommand

  HammerCLIForeman::Hostgroup::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Hostgroup::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Hostgroup::InfoCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::HostgroupInfo.new
  )
  HammerCLIForeman::Hostgroup::ListCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::HostgroupList.new
  )
#TODO - adding puppet class options
#TODO - resolver
end
