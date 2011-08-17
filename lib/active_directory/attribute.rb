module ActiveDirectory

  class Attribute
    attr_accessor :name, :ldap_name, :attribute_type, :type_klass

    def initialize(attributes = {})
      attribute_type = (attributes.delete(:attribute_type) || attributes.delete("attribute_type"))
      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
      self.type_klass = ActiveDirectory.config.attribute_types[attribute_type]
      unless self.type_klass
        puts attribute_type
        # raise(ActiveDirectory::NoAttributeTypeError, "There is no attribute type with the key #{attribute_type.inspect}")
      end
    end

    def apply_read(entry)
      if self.type_klass
        entry.meta_class.class_eval <<-APPLY_READ

          def #{self.name}
            unless @#{self.name}
              value = (self.fields["#{self.ldap_name}"] || []).first
              type_instance = #{self.type_klass}.new(value, "#{self.name}")
              @#{self.name} = type_instance.value
            end
            @#{self.name}
          end

        APPLY_READ
      end
    end
    def apply_write(entry)
      if self.type_klass
        entry.meta_class.class_eval <<-APPLY_WRITE

          def #{self.name}=(new_value)
            type_instance = #{self.type_klass}.new(new_value, "#{self.name}")
            @#{self.name} = type_instance.value
            self.fields["#{self.ldap_name}"] = [ *type_instance.ldap_value ].compact
            self.#{self.name}
          end

        APPLY_WRITE
      end
    end

    def inspect
      attrs_display = [ :name, :ldap_name ].collect do |name|
        "#{name}: #{self.send(name).inspect}"
      end
      attrs_display.push("attribute_type: #{self.attribute_type.class.key.inspect}") if self.attribute_type
      [ "#<#{self.class} ", attrs_display.join(", "), ">" ].join
    end

  end

end
