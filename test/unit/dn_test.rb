require 'assert'

class DnTest < Assert::Context
  desc "the dn class"
  setup do
    attr_ldap_name = :test
    @mock_class = mock()
    object = Factory.mock_object({ :class => @mock_class })
    @dn = AD::Schema::AttributeTypes::Dn.new(object, attr_ldap_name)
  end
  subject{ @dn }

  should "have key of 'dn'" do
    assert_equal 'dn', subject.class.key
  end

  should "set the value and allow it to be searched" do
    value = 'CN=joe test'
    subject.value = value
    @mock_class.expects(:find).with(value)
    assert_nothing_raised do
      subject.associated
    end
  end

  should "set associated to nil when value is nil" do
    subject.value = nil
    assert_equal nil, subject.associated
  end

end

class StructuralClassWithDnTest < DnTest
  desc "a Structural Class with a DN"
  setup do
    @class = Class.new(AD::Schema::OrganizationalPerson) do
      attributes :assistant_dn
    end
    @object = @class.new
  end
  subject{ @object }

  should "respond to assistant methods" do
    assert_respond_to :assistant_dn, subject
    assert_respond_to :assistant, subject
    assert_respond_to :'assistant_dn=', subject
    assert_respond_to :'assistant=', subject
  end
end
