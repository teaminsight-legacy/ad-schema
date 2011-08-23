require 'assert'

class BooleanTest < Assert::Context
  desc "the boolean class"
  setup do
    @attr_ldap_name = :test
    @value = ['true']
    @object = mock()
    @object.stubs(:dn).returns('something')
    @object.stubs(:fields).returns({ @attr_ldap_name => @value })
    @boolean = ActiveDirectory::Attributes::Boolean.new(@object, @attr_ldap_name)
  end
  subject{ @boolean }

  should "have key of 'boolean'" do
    assert_equal 'boolean', subject.class.key
  end

  should "return string 'false' or '0' as false" do
    expected = false
    subject.value = 'false'
    assert_equal expected, subject.value
    subject.value = '0'
    assert_equal expected, subject.value
  end

  should "return nil as nil" do
    expected = nil
    subject.value = nil
    assert_equal expected, subject.value
    subject.value = 'nil'
    assert_not_equal expected, subject.value
  end

  should "return any non-nil or false value as true" do
    expected = true
    assert_equal expected, subject.value
    subject.value = 'foobar'
    assert_equal expected, subject.value
  end
end
