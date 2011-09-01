require 'assert'

class AD::Schema::AttributeTypes::Timestamp

  class BaseTest < Assert::Context
    desc "the timestamp attribute type"
    setup do
      @attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @instance = @structural_class.new
      @timestamp = AD::Schema::AttributeTypes::Timestamp.new(@instance, @attr_ldap_name)
    end
    subject{ @timestamp }

    should "have key of 'timestamp'" do
      assert_equal 'timestamp', subject.class.key
    end
  end

  class ValueFromFieldTest < BaseTest
    desc "value_from_field method"
    setup do
      @value = 129576326457343750
      @instance.fields = { @attr_ldap_name => [ @value.to_s ] }
    end

    should "convert the timestamp to a time object" do
      expected = Time.at((@value - subject.send(:epochs_difference_in_ticks)) / 10000000).utc
      assert_equal expected, subject.value_from_field
    end
  end
  
  class SetNilFieldValuesTest < BaseTest
    desc "with nil values from the field"
    setup do
      @nil_values = [ 0, 0x7FFFFFFFFFFFFFFF ]
    end
    
    should "set the value to nil" do
      @nil_values.each do |new_value|
        @instance.fields[@attr_ldap_name] = [ new_value ]
        assert_nil subject.value_from_field
      end
    end
  end

  class SetValueWithUnixTimestampTest < BaseTest
    desc "setting the value with a unix timestamp"
    setup do
      @value = Time.now
      @timestamp.value = @value.to_f
    end

    # nanoseconds are lost with ruby 1.8
    should "set the value to the correct time" do
      assert_equal 0, (@value.utc - subject.value).to_i
    end
    should "set the ldap value to the correct windows timestamp" do
      expected = (@value.utc.to_i * 10000000) + subject.send(:epochs_difference_in_ticks)
      assert_equal expected, subject.ldap_value
    end
  end

  class SetValueWithTimeStringTest < BaseTest
    desc "setting the value with a time string"
    setup do
      @value = Time.now
      @timestamp.value = @value.to_s
    end

    # nanoseconds are lost with ruby 1.8
    should "set the value to the correct time" do
      assert_equal 0, (@value.utc - subject.value).to_i
    end
    should "set the ldap value to the correct windows timestamp" do
      expected = (@value.utc.to_i * 10000000) + subject.send(:epochs_difference_in_ticks)
      assert_equal expected, subject.ldap_value
    end
  end

  class SetValueWithTimeTest < BaseTest
    desc "setting the value with a time object"
    setup do
      @value = Time.now
      @timestamp.value = @value
    end

    should "set the value to the correct time" do
      assert_equal @value.utc, subject.value
    end
    should "set the ldap value to the correct windows timestamp" do
      expected = (@value.utc.to_f * 10000000) + subject.send(:epochs_difference_in_ticks)
      assert_equal expected, subject.ldap_value
    end
  end
  
  class SetValueWithNilTest < BaseTest
    desc "setting the value with nil"
    setup do
      @value = nil
      @timestamp.value = @value
    end

    should "set the value to nil" do
      assert_equal @value, subject.value
    end
    should "set the ldap value to nil" do
      assert_equal @value, subject.ldap_value
    end
  end

end
