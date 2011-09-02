require 'assert'

class AD::Schema::AttributeTypes::UnicodePassword

  class BaseTest < Assert::Context
    desc "the unicode password attribute type"
    setup do
      @attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @instance = @structural_class.new
      @password = AD::Schema::AttributeTypes::UnicodePassword.new(@instance, @attr_ldap_name)
    end
    subject{ @password }

    should "have key of 'unicode_password'" do
      assert_equal 'unicode_password', subject.class.key
    end
  end

  class SetValueTest < BaseTest
    desc "setting the value"
    setup do
      @value = "password"
      @password.value = @value
    end

    should "not set the attribute type's value" do
      assert_nil subject.value
    end
    should "not set the attribute type's ldap value" do
      assert_nil subject.ldap_value
    end
    should "set the object's fields with a modified password" do
      expected = @value.inspect.split('').collect{|c| "#{c}\000"}.join
      assert_equal [ expected ], @instance.fields[@attr_ldap_name]
    end
  end

end
