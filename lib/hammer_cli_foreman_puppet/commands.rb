module HammerCLIForemanPuppet
  RESOURCE_NAME_MAPPING = {
    puppetclass: :puppet_class,
    puppetclasses: :puppet_classes,
    environment: :puppet_environment,
    environments: :puppet_environments,
  }.freeze

  RESOURCE_ALIAS_NAME_MAPPING = {
    environment: :puppet_environment,
    environments: :puppet_environments,
  }.freeze

  module ResolverCommons
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def api_connection
        if HammerCLI.context[:api_connection]
          HammerCLI.context[:api_connection].get('foreman')
        else
          HammerCLI::Connection.get('foreman').api
        end
      end

      def resolver
        HammerCLIForemanPuppet::IdResolver.new(
          api_connection,
          HammerCLIForemanPuppet::Searchables.new
        )
      end

      def resource_name_mapping
        HammerCLIForemanPuppet::RESOURCE_NAME_MAPPING.dup
      end

      def searchables
        @searchables ||= HammerCLIForemanPuppet::Searchables.new
        @searchables
      end
    end
  end

  class Command < HammerCLIForeman::Command
    include HammerCLIForemanPuppet::ResolverCommons
  end

  class UpdateCommand < HammerCLIForeman::UpdateCommand
    include HammerCLIForemanPuppet::ResolverCommons
  end

  class InfoCommand < HammerCLIForeman::InfoCommand
    include HammerCLIForemanPuppet::ResolverCommons
  end

  class CreateCommand < HammerCLIForeman::CreateCommand
    include HammerCLIForemanPuppet::ResolverCommons
  end

  class DeleteCommand < HammerCLIForeman::DeleteCommand
    include HammerCLIForemanPuppet::ResolverCommons
  end

  class ListCommand < HammerCLIForeman::ListCommand
    include HammerCLIForemanPuppet::ResolverCommons
  end

  class AddAssociatedCommand < HammerCLIForeman::AddAssociatedCommand
    include HammerCLIForemanPuppet::ResolverCommons
  end

  class RemoveAssociatedCommand < HammerCLIForeman::RemoveAssociatedCommand
    include HammerCLIForemanPuppet::ResolverCommons
  end
end
