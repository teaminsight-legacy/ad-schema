require 'assert'

class AD::Schema::AttributeTypes::GeneralizedTime

  class BaseTest < Assert::Context
    desc "the generalized time attribute type"
    setup do
      attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @instance = @structural_class.new
      @generalized_time = AD::Schema::AttributeTypes::GeneralizedTime.new(@instance, attr_ldap_name)
    end
    subject{ @generalized_time }

    should "have key of 'generalized_time'" do
      assert_equal 'generalized_time', subject.class.key
    end
  end

  class SetValueWindowsStringTest < BaseTest
    desc "setting the value"
    setup do
      @value = "20080505170144.0Z"
      @generalized_time.value = @value
    end
    subject{ @generalized_time }

    should "have converted the windows timestamp to time object in utc" do
      expected = Time.parse(@value).utc
      assert_equal expected, subject.value
      assert subject.value.utc?
    end
    should "have stored the ldap value as a windows time string" do
      assert_equal @value, subject.ldap_value
    end
  end

  class SetValueTimeStringTest < BaseTest
    desc "setting the value"
    setup do
      @value = Time.now.to_s
      @generalized_time.value = @value
      @expected = Time.parse(@value).utc
    end
    subject{ @generalized_time }

    should "have converted the windows timestamp to time object in utc" do
      assert_equal @expected, subject.value
      assert subject.value.utc?
    end
    should "have stored the ldap value as a windows time string" do
      @expected = @expected.iso8601.gsub(/[-|:|T]/, '').gsub(/Z$/, '.0Z')
      assert_equal @expected, subject.ldap_value
    end
  end

  class SetValueTimeTest < BaseTest
    desc "setting the value"
    setup do
      @value = Time.now.utc
      @generalized_time.value = @value
    end
    subject{ @generalized_time }

    should "have converted the windows timestamp to time object in utc" do
      assert_equal @value, subject.value
      assert subject.value.utc?
    end
    should "have stored the ldap value as a windows time string" do
      expected = @value.iso8601.gsub(/[-|:|T]/, '').gsub(/Z$/, '.0Z')
      assert_equal expected, subject.ldap_value
    end
  end

end
