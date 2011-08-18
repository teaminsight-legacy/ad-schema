module ActiveDirectory
  module Attributes

    class Base

      class << self

        def apply_read(attribute, entry)
          entry.meta_class.class_eval <<-APPLY_READ

            def #{attribute.name}
              unless @#{attribute.name}
                value = (self.fields["#{attribute.ldap_name}"] || []).first
                type_instance = #{attribute.type_klass}.new(value, "#{attribute.name}")
                @#{attribute.name} = type_instance.value
              end
              @#{attribute.name}
            end

          APPLY_READ
        end
        def apply_write(attribute, entry)
          entry.meta_class.class_eval <<-APPLY_WRITE

            def #{attribute.name}=(new_value)
              type_instance = #{attribute.type_klass}.new(new_value, "#{attribute.name}")
              @#{attribute.name} = type_instance.value
              self.fields["#{attribute.ldap_name}"] = [ *type_instance.ldap_value ].compact
              if self.respond_to?("#{attribute.name}")
                self.#{attribute.name}
              else
                new_value
              end
            end

          APPLY_WRITE
        end

        def key(new_value = nil)
          if new_value
            @key = new_value
          end
          @key
        end

      end

    end

  end
end
