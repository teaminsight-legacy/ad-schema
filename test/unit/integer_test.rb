require 'assert'

class IntegerTest < Assert::Context
  desc "the integer class"
  setup do
    @attr_ldap_name = :test
    @value = [1]
    @object = mock()
    @object.stubs(:dn).returns('something')
    @object.stubs(:fields).returns({ @attr_ldap_name => @value })
    @integer = ActiveDirectory::Attributes::Integer.new(@object, @attr_ldap_name)
  end
  subject{ @integer }

  should "have key of 'integer'" do
    assert_equal 'integer', subject.class.key
  end

  should "set the new value to an integer" do
    subject.value = '2'
    assert_equal 2, subject.value
  end

  should "set the value to nil" do
    subject.value = nil
    assert_equal nil, subject.value
  end
end
