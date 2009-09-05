class LdapGroup < ActiveLdap::Base
  ldap_mapping :dn_attribute => "cn",
    :scope => :sub,
    :prefix => "ou=groups,o=users"
  
  has_many :members, :class_name => "LdapUser", :wrap => "member", 
    :primary_key => "dn", :foreign_key => "dn"
end