require 'hammer_cli_foreman_puppet/puppet_class'
require 'hammer_cli_foreman/host'

module HammerCLIForemanPuppet

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

  class InfoCommand < HammerCLIForeman::InfoCommand
    output do
      field nil, _("Puppet Environment"), HammerCLIForeman::Fields::SingleReference, :key => :environment
      field nil, _("Puppet CA Proxy"), HammerCLIForeman::Fields::SingleReference, :key => :puppet_ca_proxy
      field nil, _("Puppet Master Proxy"), HammerCLIForeman::Fields::SingleReference, :key => :puppet_proxy
    end
  end

  HammerCLIForeman::Host.subcommand 'puppetclass',
                                     HammerCLIForemanPuppet::PuppetClassesCommand.desc,
                                     HammerCLIForemanPuppet::PuppetClassesCommand
  
 HammerCLIForeman::Host::InfoCommand.subcommand 'puppet-info',
                                    HammerCLIForemanPuppet::InfoCommand.desc,
                                    HammerCLIForemanPuppet::InfoCommand

  HammerCLIForeman::Host::ListCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Host::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Host::CommonUpdateOptions.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
end