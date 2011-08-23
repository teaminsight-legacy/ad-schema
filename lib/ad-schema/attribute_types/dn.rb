require 'ad-schema/attribute_types/string'

module AD
  module Schema
    module AttributeTypes

      class Dn < AD::Schema::AttributeTypes::String
        key "dn"
        
        def value=(new_value)
          super(new_value)
          @associated = nil
        end
        
        def associated
          if self.value
            @associated ||= AD::Framework::StructuralClass.find(self.value)
          end
        end

        class << self

          def reader_method(attribute)
            method_name = attribute.name.to_s.gsub(/_dn/, '')
            <<-DEFINE_READER

              #{super}

              def #{method_name}
                self.#{attribute.name}_attribute_type.associated
              end

            DEFINE_READER
          end

          def writer_method(attribute)
            method_name = attribute.name.to_s.gsub(/_dn/, '')
            <<-DEFINE_WRITER

              #{super}

              def #{method_name}=(new_value)
                new_value = if new_value.kind_of?(AD::Framework::StructuralClass)
                  new_value.dn
                else
                  new_value.to_s
                end
                self.#{attribute.name} = new_value
                self.#{method_name}
              end

            DEFINE_WRITER
          end

        end
      end

    end
  end
end

AD::Framework.register_attribute_type(AD::Schema::AttributeTypes::Dn)
