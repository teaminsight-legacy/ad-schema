require 'assert'

class BooleanTest < Assert::Context
  desc "the boolean class"
  setup do
    @boolean = ActiveDirectory::Attributes::Boolean.new('true')
  end
  subject{ @boolean }

  should have_accessor :value

  should "return string 'false' or '0' as false" do
    assert_equal false, ActiveDirectory::Attributes::Boolean.new('false').value
    assert_equal false, ActiveDirectory::Attributes::Boolean.new('0').value
  end

  should "return nil as nil" do
    assert_equal nil, ActiveDirectory::Attributes::Boolean.new(nil).value
    assert_not_equal nil, ActiveDirectory::Attributes::Boolean.new('nil').value
  end

  should "return any non-nil or false value as true" do
    assert_equal true, @boolean.value
    assert_equal true, ActiveDirectory::Attributes::Boolean.new('foobar').value
  end
end
