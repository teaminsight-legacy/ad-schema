require 'time'
require 'ad-framework/attribute_type'

module AD
  module Schema
    module AttributeTypes

      class Timestamp < AD::Framework::AttributeType
        key "timestamp"

        def value_from_field
          field_value = (self.object.fields[self.attr_ldap_name] || []).first
          self.windows_timestamp_to_time(field_value.to_i)
        end

        def value=(new_value)
          parsed_value = case new_value
          when Time
            new_value.utc
          when Numeric
            Time.at(new_value.to_i).utc
          else
            Time.parse(new_value.to_s).utc if new_value
          end
          super(parsed_value)
        end

        def ldap_value=(new_value)
          super(self.time_to_windows_timestamp(new_value))
        end

        protected
        
        # Note that IEEE 754 double is not accurate enough to represent number of nanoseconds 
        # from the Epoch.
        def time_to_windows_timestamp(time)
          if time
            unix_timestamp_in_ticks = time.to_f * self.ticks_per_second
            unix_timestamp_in_ticks + self.epochs_difference_in_ticks
          end
        end

        # TODO: explain what is being done here, how we are converting from windows ticks to
        # unix timestamp and back
        def windows_timestamp_to_time(windows_timestamp)
          if !self.nil_values.include?(windows_timestamp.to_i)
            unix_timestamp_in_ticks = windows_timestamp.to_i - self.epochs_difference_in_ticks
            Time.at(unix_timestamp_in_ticks / self.ticks_per_second).utc
          end
        end

        def epochs_difference_in_ticks
          unless @epochs_difference_in_ticks
            difference = (self.unix_time_epoch - self.ansi_date_epoch).to_f
            @epochs_difference_in_ticks = difference * self.ticks_per_second
          end
          @epochs_difference_in_ticks
        end
        def unix_time_epoch
          @unix_time_epoch ||= Time.utc(1970, 1, 1)
        end
        def ansi_date_epoch
          @ansi_date_epoch ||= Time.utc(1601, 1, 1)
        end
        def ticks_per_second
          10000000.0
        end

        def nil_values
          [ nil, 0, 0x7FFFFFFFFFFFFFFF ]
        end

      end

    end
  end
end

AD::Framework.register_attribute_type(AD::Schema::AttributeTypes::Timestamp)
