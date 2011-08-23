require 'assert'

class AD::Schema::AttributeTypes::Integer
  
  class BaseTest < Assert::Context
    desc "the integer class"
    setup do
      attr_ldap_name = :test
      object = Factory.mock_object
      @integer = AD::Schema::AttributeTypes::Integer.new(object, attr_ldap_name)
    end
    subject{ @integer }

    should "have key of 'integer'" do
      assert_equal 'integer', subject.class.key
    end

    should "set the new value to an integer" do
      subject.value = '2'
      assert_equal 2, subject.value
    end
    should "try to convert any value to an integer" do
      assert_raises(NoMethodError) do
        subject.value = true
      end
    end

    should "set the value to nil" do
      subject.value = nil
      assert_equal nil, subject.value
    end
  end
  
end
