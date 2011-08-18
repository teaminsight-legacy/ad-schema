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
        raise(ActiveDirectory::NoAttributeTypeError, "There is no attribute type with the key #{attribute_type.inspect}")
      end
    end

    def apply_read(entry)
      if self.type_klass
        self.type_klass.apply_read(self, entry)
      end
    end
    def apply_write(entry)
      if self.type_klass
        self.type_klass.apply_write(self, entry)
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
