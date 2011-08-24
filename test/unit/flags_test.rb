require 'assert'

class AD::Schema::AttributeTypes::Flags

  class BaseTest < Assert::Context
    desc "the flags class"
    setup do
      @attr_ldap_name = :test
      @value = ['foo']
      @object = mock()
      @object.stubs(:dn).returns('something')
      @object.stubs(:fields).returns({ @attr_ldap_name => @value })
      @current_defined_values = AD::Schema::AttributeTypes::Flags.defined_values.dup
      AD::Schema::AttributeTypes::Flags.instance_variable_set("@defined_values", nil)
      AD::Schema::AttributeTypes::Flags.defined_values.stubs(:[]).with(:test).returns([])
      @flags = AD::Schema::AttributeTypes::Flags.new(@object, @attr_ldap_name)
    end
    subject{ @flags }

    should have_accessor :meta_class, :accepted_values

    should "have key of 'flags'" do
      assert_equal 'flags', subject.class.key
    end

    teardown do
      AD::Schema::AttributeTypes::Flags.instance_variable_set("@defined_values", @current_defined_values)
    end
  end

  class SystemFlagsTest < Assert::Context
    desc "the flags class with ldap name systemflags"
    setup do
      @attr_ldap_name = :systemflags
      @value = ['1610612736']
      @accepted = [
        :naming_context_domain, :can_be_moved_with_restrictions, :category_one_object,
        :constructed, :can_be_moved, :deleted_immediately, :can_be_renamed, :not_replicated,
        :cannot_be_moved, :replicated_to_global_catalog, :cannot_be_renamed, :naming_context_ntds,
        :cannot_be_deleted
      ]
      @object = mock()
      @object.stubs(:dn).returns('something')
      @object.stubs(:fields).returns({ @attr_ldap_name => @value })
      @system_flags = AD::Schema::AttributeTypes::Flags.new(@object, @attr_ldap_name)
    end
    subject{ @system_flags }

    should "have proper accepted_values" do
      assert_equal @accepted.map(&:to_s).sort, subject.accepted_values.keys.map(&:to_s).sort
    end

    should "respond to methods for all accepted_values" do
      @accepted.each do |value|
        assert_respond_to value, subject
        assert_respond_to "#{value}=", subject
      end
    end
  end

  class AccountControlTest < Assert::Context
    desc "the flags class with ldap name useraccountcontrol"
    setup do
      @attr_ldap_name = :useraccountcontrol
      @value = ['544']
      @accepted = [
        :password_permanent, :execute_logon_script, :preauth_optional, :can_send_encrypted_password,
        :mns_logon, :disabled, :password_expired, :normal, :smartcard_required, :local,
        :home_directory_required, :authenticate_for_delegation_trusted, :domain_trust,
        :delegation_trusted, :locked_out, :workstation_trust, :not_delegated, :no_password_required,
        :server_trust, :use_des_key_only, :password_locked
      ]
      @object = mock()
      @object.stubs(:dn).returns('something')
      @object.stubs(:fields).returns({ @attr_ldap_name => @value })
      @account_control = AD::Schema::AttributeTypes::Flags.new(@object, @attr_ldap_name)
    end
    subject{ @account_control }

    should "have proper accepted_values" do
      assert_equal @accepted.map(&:to_s).sort, subject.accepted_values.keys.map(&:to_s).sort
    end

    should "respond to methods for all accepted_values" do
      @accepted.each do |value|
        assert_respond_to value, subject
        assert_respond_to "#{value}=", subject
      end
    end
  end

  class TrueBitTest < Assert::Context
    desc "the flags class with ldap name useraccountcontrol and 0 seed"
    setup do
      @attr_ldap_name = :useraccountcontrol
      @value = ['0']
      @object = mock()
      @object.stubs(:dn).returns('something')
      @object.stubs(:fields).returns({ @attr_ldap_name => @value })
      @account_control = AD::Schema::AttributeTypes::Flags.new(@object, @attr_ldap_name)
    end
    subject{ @account_control }

    should "flip the bits when changing values" do
      expected = 0x00000002
      subject.disabled = true
      assert_equal expected, subject.ldap_value
    end

    should "turn non-false values into true" do
      expected = true
      value = subject.send(:to_boolean, true)
      assert_equal expected, value
      value = subject.send(:to_boolean, 'foobar')
      assert_equal expected, value
    end
  end

  class FalseBitTest < Assert::Context
    desc "the flags class with ldap name useraccountcontrol and 2 seed"
    setup do
      @attr_ldap_name = :useraccountcontrol
      @value = [0x00000002]
      @object = mock()
      @object.stubs(:dn).returns('something')
      @object.stubs(:fields).returns({ @attr_ldap_name => @value })
      @account_control = AD::Schema::AttributeTypes::Flags.new(@object, @attr_ldap_name)
    end
    subject{ @account_control }

    should "flip the bits when changing values" do
      expected = 0
      subject.disabled = false
      assert_equal expected, subject.ldap_value
    end

    should "turn nil values into false" do
      expected = false
      value = subject.send(:to_boolean, nil)
      assert_equal expected, value
    end
  end

end