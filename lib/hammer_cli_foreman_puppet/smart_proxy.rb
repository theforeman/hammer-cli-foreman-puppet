require 'hammer_cli_foreman/smart_proxy'

module HammerCLIForemanPuppet
  class ImportPuppetClassesCommand < HammerCLIForemanPuppet::Command
    action :import_puppetclasses

    command_name "import-classes"
    desc _("Import Puppet classes from Puppet proxy")
    option "--dryrun", :flag, _("Do not run the import")


    output do
      field :message, _("Result"), Fields::LongText
      collection :results, _("Changed environments"), :hide_blank => true do
        field :name, nil
        collection :new_puppetclasses, _("New classes"), :hide_blank => true, :numbered => false do
          field nil, nil
        end
        collection :updated_puppetclasses, _("Updated classes"), :hide_blank => true, :numbered => false do
          field nil, nil
        end
        collection :obsolete_puppetclasses, _("Removed classes"), :hide_blank => true, :numbered => false do
          field nil, nil
        end
        collection :ignored_puppetclasses, _("Ignored classes"), :hide_blank => true, :numbered => false do
          field nil, nil
        end
      end
    end

    build_options do |o|
      o.without(:smart_proxy_id, :dryrun)
      o.expand.except(:smart_proxies)
    end

    def request_params
      opts = super
      opts['dryrun'] = option_dryrun? || false
      opts
    end

    def transform_format(data)
      # Overriding the default behavior that tries to remove nesting
      # when there's only {"message": "..."}
      data
    end

    def print_data(record)
      print_record(output_definition, record)
    end

    extend_with(HammerCLIForemanPuppet::CommandExtensions::PuppetEnvironment.new)
  end
  HammerCLIForeman::SmartProxy.subcommand 'import-classes',
                                           HammerCLIForemanPuppet::ImportPuppetClassesCommand.desc,
                                           HammerCLIForemanPuppet::ImportPuppetClassesCommand
end
