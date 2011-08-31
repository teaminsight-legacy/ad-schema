require 'assert'

class AD::Schema::AttributeTypes::Flags

  class BaseTest < Assert::Context
    desc "the flags attribute type"
    setup do
      State.preserve
      attr_ldap_name = :test
      @structural_class = Factory.structural_class
      @instance = @structural_class.new
      @flags = AD::Schema::AttributeTypes::Flags.new(@instance, attr_ldap_name)
    end
    subject{ @flags }

    should have_accessor :meta_class, :accepted_values

    should "have key of 'flags'" do
      assert_equal 'flags', subject.class.key
    end

    teardown do
      State.restore
    end
  end
  
  class SetFlagTest < Assert::Context
    setup do
      @structural_class = Factory.structural_class do
        attributes :account_control
      end
      @instance = @structural_class.new
      @account_control = AD::Schema::AttributeTypes::Flags.new(@instance, :useraccountcontrol, 0)
    end
  end
  
  class SetFlagTrueTest < SetFlagTest
    desc "setting a flag value to true"
    setup do
      @value = 0
      @account_control.value = @value
      @account_control.disabled = true
    end
    subject{ @account_control }
    
    should "have flipped the bit for disabled" do
      expected = @value ^ subject.accepted_values[:disabled]
      assert_equal expected, subject.ldap_value
    end
  end

  class SetFlagFalseTest < SetFlagTest
    desc "setting a flag value to false"
    setup do
      @value = subject.accepted_values[:disabled]
      @account_control.value = @value
      @account_control.disabled = false
    end
    subject{ @account_control }
    
    should "have flipped the bit for disabled" do
      expected = @value ^ subject.accepted_values[:disabled]
      assert_equal expected, subject.ldap_value
    end
  end
  
  class SetFlagNilTest < SetFlagTest
    desc "setting a flag value to nil"
    setup do
      @value = subject.accepted_values[:disabled]
      @account_control.value = @value
      @account_control.disabled = nil
    end
    subject{ @account_control }
    
    should "have flipped the bit for disabled" do
      expected = @value ^ subject.accepted_values[:disabled]
      assert_equal expected, subject.ldap_value
    end
  end  

end
