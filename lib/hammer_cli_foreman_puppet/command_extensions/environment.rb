# frozen_string_literal: true

module HammerCLIForemanPuppet
  module CommandExtensions
    class PuppetEnvironment < HammerCLI::CommandExtensions
      # FIXME: Temp workaround for option builders in case of multiple plugins
      # extensions of the same command
      option_family do
        parent '--puppet-environment-id', 'PUPPET_ENVIRONMENT_ID', _('ID of associated Puppet environment'),
          format: HammerCLI::Options::Normalizers::Number.new,
          attribute_name: :option_environment_id
        child '--puppet-environment', 'PUPPET_ENVIRONMENT_NAME', _('Name of associated Puppet environment'),
          attribute_name: :option_environment_name
      end

      option_sources do |sources, command|
        sources.find_by_name('IdResolution').insert_relative(
          :after,
          'IdParams',
          HammerCLIForemanPuppet::OptionSources::PuppetEnvironmentParams.new(command)
        )
        sources
      end
    end
  end
end
