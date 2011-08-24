require 'assert'

class GeneralizedTimeTest < Assert::Context
  desc "the generalized_time class"
  setup do
    @attr_ldap_name = :test
    @value = ["20080505170144.0Z"]
    @object = mock()
    @object.stubs(:dn).returns('something')
    @object.stubs(:fields).returns({ @attr_ldap_name => @value })
    @generalized_time = AD::Schema::AttributeTypes::GeneralizedTime.new(@object, @attr_ldap_name)
  end
  subject{ @generalized_time }

  should "have key of 'generalized_time'" do
    assert_equal 'generalized_time', subject.class.key
  end

  should "convert the timestring into a utc Unix style time" do
    expected = Time.parse('2008-05-05 17:01:44 UTC')
    assert_equal expected, subject.value
    assert subject.value.utc?
  end

  should "convert a Unix time into a windows accepted string" do
    expected = "20101010101010.0Z"
    parsed = Time.parse('2010-10-10 10:10:10 UTC')
    assert_equal expected, subject.send(:windows_time_string, parsed)
  end
end
