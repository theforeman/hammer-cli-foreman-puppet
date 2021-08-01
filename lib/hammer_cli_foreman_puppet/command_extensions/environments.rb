module HammerCLIForemanPuppet
  module CommandExtensions
    class PuppetEnvironments < HammerCLI::CommandExtensions
      # FIXME: Temp workaround for option builders in case of multiple plugins
      # extensions of the same command
      option_family do
        parent '--puppet-environment-ids', 'PUPPET_ENVIRONMENT_IDS', _('IDs of associated Puppet environment'),
               format: HammerCLI::Options::Normalizers::List.new,
               attribute_name: :option_environment_ids
        child '--puppet-environments', 'PUPPET_ENVIRONMENT_NAMES', _('Names of associated Puppet environment'),
              attribute_name: :option_environment_names
      end

      option_sources do |sources, command|
        sources.find_by_name('IdResolution').insert_relative(
          :after,
          'IdsParams',
          HammerCLIForemanPuppet::OptionSources::PuppetEnvironmentParams.new(command)
        )
        sources
      end
    end
  end
end
