module "aci_fabric_wide_settings" {
  source = "netascode/fabric-wide-settings/aci"

  domain_validation             = true
  enforce_subnet_check          = true
  opflex_authentication         = false
  disable_remote_endpoint_learn = true
  overlapping_vlan_validation   = true
  remote_leaf_direct            = true
}
