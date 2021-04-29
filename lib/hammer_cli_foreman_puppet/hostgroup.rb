
require 'hammer_cli_foreman/hostgroup'

module HammerCLIForemanPuppet
  class PuppetClassesCommand < HammerCLIForeman::ListCommand
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

  HammerCLIForeman::Hostgroup.subcommand 'puppetclass',
                                           HammerCLIForemanPuppet::PuppetClassesCommand.desc,
                                           HammerCLIForemanPuppet::PuppetClassesCommand

  HammerCLIForeman::Hostgroup::CreateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Hostgroup::UpdateCommand.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )

#TODO - adding puppet class options
#TODO - resolver
end
