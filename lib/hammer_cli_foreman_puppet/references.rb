module HammerCLIForemanPuppet

  module References

    def self.environments(dsl)
      dsl.build do
        collection :environments, _("Environments"), :numbered => false do
          custom_field Fields::Reference
        end
      end
    end

    def self.puppetclasses(dsl)
      dsl.build do
        collection :puppetclasses, _("Puppetclasses"), :numbered => false do
          custom_field Fields::Reference
        end
      end
    end

  end
end
