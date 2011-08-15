module ActiveDirectory

  class Attribute
    attr_accessor :name, :ldap_name, :attribute_type

    def initialize(attributes = {})
      attribute_type = (attributes.delete(:attribute_type) || attributes.delete("attribute_type"))
      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
      attribute_type_klass = ActiveDirectory.config.attribute_types[attribute_type]
      if attribute_type_klass
        self.attribute_type = attribute_type_klass.new(self)
      else
        # raise(ActiveDirectory::NoAttributeTypeError, "There is no attribute type with the key #{attribute_type.inspect}")
      end
    end

    def apply_read(entry)
      if self.attribute_type
        self.attribute_type.apply_read(entry)
      end
    end
    def apply_write(entry)
      if self.attribute_type
        self.attribute_type.apply_write(entry)
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
