# frozen_string_literal: true

module HammerCLIForemanPuppet
  module PuppetIdResolver
    # puppet class search results are in non-standard format
    # and needs to be un-hashed first
    def puppetclass_id(options)
      return options[HammerCLI.option_accessor_name('id')] if options[HammerCLI.option_accessor_name('id')]

      resource = @api.resource(:puppetclasses)
      results = find_resource_raw(:puppetclasses, options)
      require('hammer_cli_foreman_puppet/class')
      results = HammerCLIForemanPuppet::PuppetClass::ListCommand.unhash_classes(results)
      pick_result(results, resource)['id']
    end

    def puppetclass_ids(options)
      resource_name = :puppetclasses
      resource = @api.resource(resource_name)
      results = if (ids = options[HammerCLI.option_accessor_name('ids')])
                  ids
                elsif (ids = nil_from_searchables(resource_name, options, plural: true))
                  ids
                elsif options_not_set?(resource, options)
                  raise HammerCLIForeman::MissingSearchOptions.new(_('Missing options to search %s') % resource.name, resource)
                elsif options_empty?(resource, options)
                  []
                else
                  require('hammer_cli_foreman_puppet/class')
                  results = HammerCLIForemanPuppet::PuppetClass::ListCommand.unhash_classes(
                    resolved_call(resource_name, :index, options, :multi)
                  )
                  if results.count < expected_record_count(
                    options, resource, :multi
                  )
                    raise HammerCLIForeman::ResolverError.new(_('one of %s not found.') % resource.name,
                      resource)
                  end
                  results.map { |r| r['id'] }
                end
    end

    def puppet_environment_id(options)
      get_id(:environments, options)
    end

    def puppet_environment_ids(options)
      get_ids(:environments, options)
    end

    def create_puppetclasses_search_options(options, mode = nil)
      searchables(@api.resource(:puppetclasses)).each do |s|
        value = options[HammerCLI.option_accessor_name(s.name.to_s)]
        values = options[HammerCLI.option_accessor_name(s.plural_name.to_s)]
        if value && (mode.nil? || mode == :single)
          return { search: "#{s.name} = \"#{value}\"" }
        elsif values && (mode.nil? || mode == :multi)
          query = values.map { |v| "#{s.name} = \"#{v}\"" }.join(' or ')
          return { search: query }
        end
      end
      {}
    end

    def create_smart_class_parameters_search_options(options, _mode = nil)
      search_options = {}
      value = options[HammerCLI.option_accessor_name('name')]
      search_options[:search] = "key = \"#{value}\""
      search_options[:puppetclass_id] = puppetclass_id(scoped_options('puppetclass', options))
      search_options
    end
  end

  class Searchables < HammerCLIForeman::Searchables
    SEARCHABLES = {
      environment: [s_name(_('Puppet environment name'))],
      puppet_environment: [s_name(_('Puppet environment name'))],
      puppetclass: [s_name(_('Puppet class name'))],
      smart_class_parameter: [s_name(_('Smart class parameter name'), editable: false)],
    }.freeze

    DEFAULT_SEARCHABLES = [s_name(_('Name to search by'))].freeze

    def for(resource)
      SEARCHABLES[resource.singular_name.to_sym] || super(resource)
    end
  end

  class IdResolver < HammerCLIForeman::IdResolver
  end
  # Temp workaround for resolvers in case of multiple plugins
  # extensions of the same command
  HammerCLIForeman::IdResolver.include HammerCLIForemanPuppet::PuppetIdResolver
end
