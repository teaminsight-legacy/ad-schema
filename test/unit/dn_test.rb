require 'assert'

class DnTest < Assert::Context
  desc "the dn class"
  setup do
    @attr_ldap_name = :test
    @value = ['some value']
    @object = mock()
    @object.stubs(:dn).returns('something')
    @object.stubs(:fields).returns({ @attr_ldap_name => @value })
    @dn = AD::Schema::AttributeTypes::Dn.new(@object, @attr_ldap_name)
  end
  subject{ @dn }

  should "have key of 'dn'" do
    assert_equal 'dn', subject.class.key
  end

end
