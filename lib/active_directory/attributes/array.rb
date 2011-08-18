require 'ad-framework/attribute_type'
require 'active_directory/attributes/string'

module ActiveDirectory
  module Attributes

    class Array < AD::Framework::AttributeType
      key "array"

      attr_accessor :value_type

      def initialize(object, attr_ldap_name, values)
        self.value_type = case attr_ldap_name.to_sym
        when :proxyaddresses
          ActiveDirectory::Attributes::String
        else
          ActiveDirectory::Attributes::String
        end
        super
      end

      def value
        [*@value].collect(&:value)
      end

      def value=(new_value)
        values = [*new_value].collect do |value|
          self.value_type.new(object, attr_ldap_name, value)
        end
        super(values.compact)
      end

      def ldap_value=(new_value)
        super(new_value.collect(&:value))
      end

      class << self
        def define_attribute_type(attribute, klass)
          attribute_type_method = "#{attribute.name}_attribute_type"
          if !klass.instance_methods.collect(&:to_s).include?(attribute_type_method)
            klass.class_eval <<-DEFINE_ATTRIBUTE_TYPE

              def #{attribute_type_method}
                unless @#{attribute_type_method}
                  value = (self.fields["#{attribute.ldap_name}"] || [])
                  type = #{attribute.attribute_type}.new(self, "#{attribute.ldap_name}", value)
                  @#{attribute_type_method} = type
                end
                @#{attribute_type_method}
              end

            DEFINE_ATTRIBUTE_TYPE
          end
        end
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::Array)
