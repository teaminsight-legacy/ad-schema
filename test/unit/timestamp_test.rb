require 'assert'

class TimestampTest < Assert::Context
  desc "the timestamp class"
  setup do
    @attr_ldap_name = :test
    @value = ["129576326457343750"]
    @object = mock()
    @object.stubs(:dn).returns('something')
    @object.stubs(:fields).returns({ @attr_ldap_name => @value })
    @timestamp = ActiveDirectory::Attributes::Timestamp.new(@object, @attr_ldap_name)
  end
  subject{ @timestamp }

  should have_accessor :value

  should "have key of 'timestamp'" do
    assert_equal 'timestamp', subject.class.key
  end

  should "convert the timestring into a utc Unix style time" do
    expected = Time.parse('2011-08-12 14:24:05 UTC')
    assert_equal expected, subject.value
    assert subject.value.utc?
  end

  should "convert 0 and 0x7FFFFFFFFFFFFFFF to nil" do
    assert_equal nil, subject.send(:convert, 0)
    assert_equal nil, subject.send(:convert, 0x7FFFFFFFFFFFFFFF)
  end

  should "convert a Time value back into the timestring" do
    parsed = Time.parse('2010-10-10 10:10:10 UTC')
    expected = 129311790100000000
    subject.ldap_value = parsed
    assert_equal expected, subject.ldap_value
  end
end
