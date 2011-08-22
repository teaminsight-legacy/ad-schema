require 'assert'

class UnicodePasswordTest < Assert::Context
  desc "the unicode_password class"
  setup do
    @attr_ldap_name = :test
    @value = ["foo"]
    @object = mock()
    @object.stubs(:dn).returns('something')
    @object.stubs(:fields).returns({ @attr_ldap_name => @value })
    @unicode_password = ActiveDirectory::Attributes::UnicodePassword.new(@object, @attr_ldap_name)
  end
  subject{ @unicode_password }

  should "have key of 'unicode_password'" do
    assert_equal 'unicode_password', subject.class.key
  end

  should "return nil when trying to read the password" do
    assert_equal nil, subject.value
    assert_equal nil, subject.ldap_value
  end

  should "encrypt the ldap password" do
    expected = "\"\000f\000o\000o\000\"\000"
    assert_equal expected, subject.value_from_field
  end

end
