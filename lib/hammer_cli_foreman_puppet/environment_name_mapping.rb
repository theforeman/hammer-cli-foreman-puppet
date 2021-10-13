# frozen_string_literal: true
module HammerCLIForemanPuppet
  module EnvironmentNameMapping
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def resource_name_mapping
        mapping = Command.resource_name_mapping
        mapping[:environment] = :puppet_environment
        mapping[:environments] = :puppet_environments
        mapping
      end

      def resource_alias_name_mapping
        super.merge(HammerCLIForemanPuppet::RESOURCE_ALIAS_NAME_MAPPING.dup)
      end
    end
  end
end
