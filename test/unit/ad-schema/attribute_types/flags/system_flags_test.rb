=begin
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
=end