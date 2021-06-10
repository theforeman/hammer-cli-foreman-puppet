module HammerCLIForemanPuppet
  module CommandExtensions
    class PuppetEnvironments < HammerCLI::CommandExtensions
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
