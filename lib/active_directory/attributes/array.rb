require 'active_directory/attributes/base'
require 'active_directory/attributes/string'

module ActiveDirectory
  module Attributes

    class Array < ActiveDirectory::Attributes::Base
      key "array"

      attr_accessor :values

      def initialize(values, key)
        value_type = case key.to_sym
        when :proxy_address
          ActiveDirectory::Attributes::String
        else
          ActiveDirectory::Attributes::String
        end
        self.values = [*values].collect do |value|
          value_type.new(value, key)
        end
      end

      def value
        [*self.values].collect(&:value)
      end

      def ldap_value
        [*self.values].collect(&:ldap_value)
      end

      class << self
        def apply_read(attribute, entry)
          entry.meta_class.class_eval <<-APPLY_READ

            def #{attribute.name}
              unless @#{attribute.name}
                value = (self.fields["#{attribute.ldap_name}"] || [])
                type_instance = #{attribute.type_klass}.new(value, "#{attribute.name}")
                @#{attribute.name} = type_instance.value
              end
              @#{attribute.name}
            end

          APPLY_READ
        end
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::Array)
