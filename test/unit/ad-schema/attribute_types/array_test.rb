require 'assert'

class AD::Schema::AttributeTypes::Array

  class BaseTest < Assert::Context
    desc "the array attribute type"
    setup do
      @attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @fields = { @attr_ldap_name.to_sym => [ 'foo', 'bar' ] }
      @instance = @structural_class.new({ :fields => @fields })
      @array = AD::Schema::AttributeTypes::Array.new(@instance, @attr_ldap_name)
    end
    subject{ @array }

    should have_accessor :item_class

    should "have key of 'array'" do
      assert_equal 'array', subject.class.key
    end

    should "return values as 'AD::Schema::AttributeTypes::String'" do
      assert_equal AD::Schema::AttributeTypes::String, subject.item_class
    end

    should "return correct value from field" do
      assert_equal @fields[@attr_ldap_name], subject.value_from_field
    end
  end

  class ValueTest < BaseTest
    desc "value method"
    setup do
      @values = @fields[@attr_ldap_name].collect do |value|
        item = mock()
        item.expects(:value).returns(value)
        item
      end
      @array.instance_variable_set("@value", @values)
    end

    should "return the value of each item in the collection" do
      assert_nothing_raised{ @array.value }
    end
  end

  class SetValueTest < BaseTest
    desc "setting the value"
    setup do
      @values = [ 'foo', 'bar', 1, true ]
      @array.value = @values
    end

    should "return the values as strings" do
      assert_equal @values.collect(&:to_s), subject.value
    end
  end

  class SetNilValueTest < BaseTest
    desc "setting with nil values"
    setup do
      @values = nil
      @array.value = @values
    end

    should "return an empty array" do
      assert_equal [], subject.value
    end
  end
  
  class SetWithNilValuesTest < BaseTest
    desc "setting with nil and non-nil values"
    setup do
      @values = [ 'foo', nil, 'bar', nil ]
      @array.value = @values
    end

    should "ignore any nil values" do
      assert_equal @values.compact, subject.value
    end
  end

end
