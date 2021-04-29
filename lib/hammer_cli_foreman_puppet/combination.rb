
require 'hammer_cli_foreman/combination'

module HammerCLIForemanPuppet
  HammerCLIForeman::Combination::InfoCombination.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Combination::UpdateCombination.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
  HammerCLIForeman::Combination::CreateCombination.extend_with(
    HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new
  )
end
