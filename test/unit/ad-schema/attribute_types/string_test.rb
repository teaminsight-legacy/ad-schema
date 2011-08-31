require 'assert'

class AD::Schema::AttributeTypes::String

  class BaseTest < Assert::Context
    desc "the string attribute type"
    setup do
      attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @instance = @structural_class.new
      @string = AD::Schema::AttributeTypes::String.new(@instance, attr_ldap_name)
    end
    subject{ @string }

    should "have key of 'string'" do
      assert_equal 'string', subject.class.key
    end
  end
  
  class SetValueTest < BaseTest
    desc "setting the value"
    setup do
      @new_value = "123"
      subject.value = @new_value.to_i
    end

    should "convert the new value to a string" do
      assert_equal @new_value, subject.value
    end
  end
  
  class MockSetValueTest < BaseTest
    desc "setting the value with mock value"
    setup do
      @new_value = mock()
      @new_value.expects(:to_s)
    end

    should "try to convert the value to a string" do
      new_value = @new_value
      assert_nothing_raised{ subject.value = new_value }
    end
  end
  
  class SetNilVAlueTest < BaseTest
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
