require 'assert'

class AD::Schema::AttributeTypes::Boolean

  class BaseTest < Assert::Context
    desc "the boolean attribute type"
    setup do
      attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @instance = @structural_class.new
      @boolean = AD::Schema::AttributeTypes::Boolean.new(@instance, attr_ldap_name)
    end
    subject{ @boolean }

    should "have key of 'boolean'" do
      assert_equal 'boolean', subject.class.key
    end
  end

  class SetFalseValueTest < BaseTest
    desc "setting value with false"
    setup do
      @new_value = false
      @boolean.value = @new_value
    end

    should "set the value to false" do
      assert_equal @new_value, subject.value
    end
  end

  class SetFalseStringValueTest < BaseTest
    desc "setting value with 'false'"
    setup do
      @new_value = false
      @boolean.value = @new_value.to_s
    end

    should "set the value to false" do
      assert_equal @new_value, subject.value
    end
  end

  class SetZeroValueTest < BaseTest
    desc "setting value with 0"
    setup do
      @new_value = 0
      @boolean.value = @new_value
    end

    should "set the value to false" do
      assert_equal false, subject.value
    end
  end

  class SetZeroStringValueTest < BaseTest
    desc "setting value with '0'"
    setup do
      @new_value = 0
      @boolean.value = @new_value.to_s
    end

    should "set the value to false" do
      assert_equal false, subject.value
    end
  end

  class SetTrueValueTest < BaseTest
    desc "setting value with true"
    setup do
      @new_value = true
      @boolean.value = @new_value
    end

    should "set the value to true" do
      assert_equal @new_value, subject.value
    end
  end
  
  class SetTruthyValueTest < BaseTest
    desc "setting value with a truthy value"
    setup do
      @new_value = "something"
      @boolean.value = @new_value
    end

    should "set the value to true" do
      assert_equal true, subject.value
    end
  end

  class SetNilValueTest < BaseTest
    desc "setting value with nil"
    setup do
      @new_value = nil
      @boolean.value = @new_value
    end

    should "set the value to nil" do
      assert_equal @new_value, subject.value
    end
  end

end
