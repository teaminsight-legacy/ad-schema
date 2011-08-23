require 'assert'

class AD::Schema::AttributeTypes::String
  
  class BaseTest < Assert::Context
    desc "the string class"
    setup do
      attr_ldap_name = :test
      object = Factory.mock_object
      @string = AD::Schema::AttributeTypes::String.new(object, attr_ldap_name)
    end
    subject{ @string }

    should "have key of 'string'" do
      assert_equal 'string', subject.class.key
    end

    should "set the new value to a string" do
      subject.value = 123
      assert_equal '123', subject.value
    end

    should "set the value to nil" do
      subject.value = nil
      assert_equal nil, subject.value
    end
  end  
  
end
