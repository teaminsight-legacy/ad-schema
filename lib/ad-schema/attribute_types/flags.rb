require 'ad-schema/attribute_types/integer'
require 'ad-schema/attribute_types/boolean'

require 'ad-schema/attribute_types/flags/system_flags'
require 'ad-schema/attribute_types/flags/user_account_control'

module AD
  module Schema
    module AttributeTypes

      class Flags < AD::Schema::AttributeTypes::Integer
        extend AD::Schema::AttributeTypes::Flags::SystemFlags
        extend AD::Schema::AttributeTypes::Flags::UserAccountControl
        
        key "flags"

        attr_accessor :meta_class, :accepted_values

        def initialize(object, attr_ldap_name)
          self.meta_class = class << self; self; end
          self.accepted_values = self.class.defined_values[attr_ldap_name.to_sym]
          super

          self.define_value_methods!
        end

        def value
          self
        end
        
        def inspect
          values_string = (self.accepted_values.collect do |name, bit|
            "#{name}?: #{self.send(name).inspect}"
          end).sort.join(", ")
          [ "#<#{self.class} ", "value: #{@value.inspect}, ", values_string, ">" ].join
        end

        protected

        def to_boolean(new_value)
          new_value = !!new_value
          args = [ self.object, self.attr_ldap_name, new_value ]
          @converter ||= AD::Schema::AttributeTypes::Boolean.new(*args)
          @converter.value = new_value
          @converter.value
        end

        # TODO: describe what this is doing, using the meta class to define methods just for this
        # instance, blah blah blah
        def define_value_methods!
          self.accepted_values.each do |(name, bit)|
            self.meta_class.class_eval <<-FLAG_METHODS

              def #{name}
                ((@value || 0) & #{bit}) != 0
              end
              alias :#{name}? :#{name}

              def #{name}=(new_value)
                boolean = self.to_boolean(new_value)
                current = self.#{name}
                if boolean ^ current
                  self.value = ((@value || 0) ^ #{bit})
                end
                self.#{name}
              end

            FLAG_METHODS
          end
        end

        class << self
          def defined_values
            unless @defined_values
              @defined_values = {}
              @defined_values.merge!(self.system_flags_values)
              @defined_values.merge!(self.user_account_control_values)
            end
            @defined_values
          end
        end

      end

    end
  end
end

AD::Framework.register_attribute_type(AD::Schema::AttributeTypes::Flags)
