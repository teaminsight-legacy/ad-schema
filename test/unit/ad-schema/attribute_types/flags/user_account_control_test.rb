=begin
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
=end