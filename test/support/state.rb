AD::Schema::AttributeTypes::Flags.instance_variable_set("@defined_values", @current_defined_values)

module State
  class << self
    attr_accessor :current_flags_defined_values

    def preserve
      self.current_flags_defined_values = AD::Schema::AttributeTypes::Flags.defined_values.dup
      self.nullify
    end

    def restore
      self.nullify
      AD::Schema::AttributeTypes::Flags.instance_variable_set(*[
        "@defined_values", self.current_flags_defined_values
      ])
    end

    protected

    def nullify
      AD::Schema::AttributeTypes::Flags.instance_variable_set("@defined_values", nil)
    end

  end
end
