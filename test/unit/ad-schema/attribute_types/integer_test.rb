require 'assert'

class AD::Schema::AttributeTypes::Integer

  class BaseTest < Assert::Context
    desc "the integer attribute type"
    setup do
      attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @instance = @structural_class.new
      @integer = AD::Schema::AttributeTypes::Integer.new(@instance, attr_ldap_name)
    end
    subject{ @integer }

    should "have key of 'integer'" do
      assert_equal 'integer', subject.class.key
    end
  end

  class SetValueTest < BaseTest
    desc "setting the value"
    setup do
      @new_value = 2
      subject.value = @new_value.to_s
    end

    should "convert the new value to an integer" do
      assert_equal @new_value, subject.value
    end
  end

  class MockSetValueTest < BaseTest
    desc "setting the value with mock value"
    setup do
      @new_value = mock()
      @new_value.expects(:to_i)
    end

    should "try to convert the value to an integer" do
      new_value = @new_value
      assert_nothing_raised{ subject.value = new_value }
    end
  end

  class SetNilValueTest < BaseTest
    desc "setting the value to nil"
    setup do
      @new_value = nil
      subject.value = @new_value
    end

    should "set the value to nil" do
      assert_equal nil, subject.value
    end
  end

end
