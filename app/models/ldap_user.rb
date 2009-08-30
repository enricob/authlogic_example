class LdapUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => "uid",
    :scope => :sub,
    :prefix => "o=users"
end