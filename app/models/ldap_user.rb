class LdapUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => "uid",
    :scope => :sub,
    :prefix => "o=users"
    
  belongs_to :groups, :class_name => "LdapGroup", :many => "member",
    :foreign_key => "dn"
end