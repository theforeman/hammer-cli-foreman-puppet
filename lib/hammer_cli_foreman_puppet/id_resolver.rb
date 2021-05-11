module HammerCLIForemanPuppet
  class Searchables < HammerCLIForeman::Searchables
    SEARCHABLES = {
      :environment =>        [s_name(_('Puppet environment name'))],
      :puppet_environment => [s_name(_('Puppet environment name'))],
      :puppetclass =>      [ s_name(_("Puppet class name")) ],
      :smart_class_parameter => [ s_name(_("Smart class parameter name"), :editable => false) ],
    }.freeze

    DEFAULT_SEARCHABLES = [s_name(_("Name to search by"))].freeze

    def for(resource)
      SEARCHABLES[resource.singular_name.to_sym] || DEFAULT_SEARCHABLES
    end
  end

  class IdResolver < HammerCLIForeman::IdResolver
    def puppetclass_ids(options)
      resource_name = :puppetclasses
      resource = @api.resource(resource_name)
      results = if (ids = options[HammerCLI.option_accessor_name("ids")])
        ids
      elsif (ids = nil_from_searchables(resource_name, options, :plural => true))
        ids
      elsif options_not_set?(resource, options)
        raise HammerCLIForeman::MissingSearchOptions.new(_("Missing options to search %s") % resource.name, resource)
      elsif options_empty?(resource, options)
        []
      else
        require('hammer_cli_foreman_puppet/class')
        results = HammerCLIForemanPuppet::PuppetClass::ListCommand.unhash_classes(
          resolved_call(resource_name, :index, options, :multi)
        )
        raise HammerCLIForeman::ResolverError.new(_("one of %s not found.") % resource.name, resource) if results.count < expected_record_count(options, resource, :multi)
          results.map { |r| r['id'] }
      end
    end

    def puppet_environment_id(options)
      get_id(:environments, options)
    end

    def puppet_environment_ids(options)
      get_ids(:environments, options)
    end
  end
end