module HammerCLIForemanPuppet
  module CommandExtensions
    class Provision < HammerCLI::CommandExtensions
      option "--puppetclass-ids", "PUPPETCLASS_IDS", " ",
        :format => HammerCLI::Options::Normalizers::List.new
    end
  end
end