require 'assert'

class StructuralClassTest < Assert::Context
  desc "the structural class"
  setup do
    @top_attrs = [:name, :system_flags, :display_name, :description, :proxy_addresses,
      :when_created, :when_changed, :admin_display_name, :admin_description, :unix_member_of]
    @person_attrs = [:last_name, :phone_number]
    @person_write_attrs = [:'password=']
    @orginizational_person_attrs = [:address, :home_address, :assistant_dn, :company_name,
      :country_code, :country_name, :department, :division, :email, :employee_id, :fax_number,
      :generation_qualifier, :first_name, :initials, :locality_name, :manager_dn, :organizational_unit,
      :other_mailbox, :middle_name]
    @user_attrs = [:account_expires, :home_directory, :home_drive, :locked_out_at, :profile_path,
      :script_path, :account_control, :parameters, :principal_name, :uid]
    @user_read_attrs = [:admin_count, :last_bad_password_at, :bad_password_count, :last_logged_in_at,
      :logged_in_count, :primary_group_id, :password_last_set_at, :service_principal_names]
    @user_write_attrs = [:'unicode_password=']

  end

  class TopTest < StructuralClassTest
    desc "an ActiveDirectory::Top"
    setup do
      @structural_class = ActiveDirectory::Top
    end
    subject{ @structural_class }

    should have_instance_methods :ldap_name, :rdn, :attributes
    should "have correct ldap_name" do
      assert_equal 'top', subject.ldap_name
    end
    should "have correct rdn" do
      assert_equal :name, subject.rdn
    end
  end

  class PersonTest < StructuralClassTest
    desc "an ActiveDirectory::Person"
    setup do
      @structural_class = ActiveDirectory::Person.new
    end
    subject{ @structural_class }

    should have_class_methods :ldap_name, :rdn, :attributes, :write_attributes
    should "have correct ldap_name" do
      assert_equal 'person', subject.class.ldap_name
    end
    should "have correct rdn" do
      assert_equal :name, subject.class.rdn
    end
    should "have respond to attribute types" do
      attrs = @top_attrs + @person_attrs
      attrs.each do |attr|
        assert_respond_to attr, subject
      end
    end
    should "have respond to write_attribute types" do
      attrs = @person_write_attrs
      attrs.each do |attr|
        assert_respond_to attr, subject
      end
    end
  end

  class OrganizationalPersonTest < StructuralClassTest
    desc "an ActiveDirectory::OrganizationalPerson"
    setup do
      @structural_class = ActiveDirectory::OrganizationalPerson.new
    end
    subject{ @structural_class }

    should have_class_methods :ldap_name, :rdn, :attributes
    should "have correct ldap_name" do
      assert_equal 'organizationalPerson', subject.class.ldap_name
    end
    should "have correct rdn" do
      assert_equal :name, subject.class.rdn
    end
    should "have respond to attribute types" do
      attrs = @top_attrs + @person_attrs + @orginizational_person_attrs
      attrs.each do |attr|
        assert_respond_to attr, subject
      end
    end
    should "have respond to write_attribute types" do
      attrs = @person_write_attrs
      attrs.each do |attr|
        assert_respond_to attr, subject
      end
    end
  end

  class UserTest < StructuralClassTest
    desc "an ActiveDirectory::User"
    setup do
      @structural_class = ActiveDirectory::User.new
    end
    subject{ @structural_class }

    should have_class_methods :ldap_name, :rdn, :attributes
    should "have correct ldap_name" do
      assert_equal 'user', subject.class.ldap_name
    end
    should "have correct rdn" do
      assert_equal :name, subject.class.rdn
    end
    should "have respond to attribute types" do
      attrs = @top_attrs + @person_attrs + @orginizational_person_attrs + @user_attrs
      attrs.each do |attr|
        assert_respond_to attr, subject
      end
    end
    should "have respond to read_attribute types" do
      attrs = @user_read_attrs
      attrs.each do |attr|
        assert_respond_to attr, subject
      end
    end
    should "have respond to write_attribute types" do
      attrs = @person_write_attrs + @user_write_attrs
      attrs.each do |attr|
        assert_respond_to attr, subject
      end
    end
  end

end