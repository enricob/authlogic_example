class User < ActiveRecord::Base
  acts_as_authentic do |c|
    # Don't validate password, since that will be held in the LDAP
    c.validate_password_field = false
  end
  
  def ldap_entry
    LdapUser.find(self.login)
  end
  
  # Tries to find a User first by looking into the database and then by
  # creating a User if there's an LDAP entry for the given login
  def self.find_or_create_from_ldap(login)
    find_by_login(login) || create_from_ldap_if_valid(login)
  end
  
  # Creates a User record in the database if there is an entry in the LDAP
  # with the given login
  def self.create_from_ldap_if_valid(login)
    begin
      User.create(:login => login) if LdapUser.find(login)
    rescue ActiveLdap::EntryNotFound
      nil # Don't do anything since we can't find an entry
    end
  end
  
  protected
    # Authenticates the user against the LDAP.
    def valid_ldap_credentials?(password_plaintext)
      ldap_entry.bind(password_plaintext)
      ldap_entry.remove_connection
      true
    rescue ActiveLdap::AuthenticationError, ActiveLdap::LdapError::UnwillingToPerform
      false
    end
end
