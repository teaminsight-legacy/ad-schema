require 'assert'

class ArrayTest < Assert::Context
  desc "the array class"
  setup do
    @attr_ldap_name = :test
    @values = ['foo', 'bar']
    @object = mock()
    @object.stubs(:dn).returns('something')
    @object.stubs(:fields).returns({ @attr_ldap_name => @values })
    @array = ActiveDirectory::Attributes::Array.new(@object, @attr_ldap_name)
  end
  subject{ @array }

  should have_accessor :item_class

  should "have key of 'array'" do
    assert_equal 'array', subject.class.key
  end

  should "return values as 'ActiveDirectory::Attributes::String'" do
    assert_equal ActiveDirectory::Attributes::String, subject.item_class
  end

  should "return correct value from field" do
    assert_equal @values, subject.value_from_field
  end

  should "return single values passed in as arrays" do
    object = mock()
    object.stubs(:value).returns('foo')
    assert_equal ['foo'], subject.send(:get_items_values, object)
  end

  should "kick out nil values" do
    assert_equal [], subject.send(:get_items_values, nil)
  end

  should "set the correct value" do
    subject.value = ['foo', 'bar', 'baz']
    assert_equal ['foo', 'bar', 'baz'], subject.value
  end
end
