# frozen_string_literal: true

module HammerCLIForemanPuppet
  module CommandExtensions
    class Provision < HammerCLI::CommandExtensions
      option_family(
        format: HammerCLI::Options::Normalizers::List.new,
        aliased_resource: 'puppet-class',
        description: 'Names/Ids of associated Puppet classes'
      ) do
        parent '--puppet-class-ids', 'PUPPET_CLASS_IDS', _('List of Puppet class ids'),
          attribute_name: :option_puppetclass_ids
        child '--puppet-classes', 'PUPPET_CLASS_NAMES', '',
          attribute_name: :option_puppetclass_names
      end
    end
  end
end
