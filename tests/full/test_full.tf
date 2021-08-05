terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  domain_validation             = true
  enforce_subnet_check          = true
  opflex_authentication         = false
  disable_remote_endpoint_learn = true
  overlapping_vlan_validation   = true
  remote_leaf_direct            = false
}

data "aci_rest" "infraSetPol" {
  dn = "uni/infra/settings"

  depends_on = [module.main]
}

resource "test_assertions" "infraSetPol" {
  component = "infraSetPol"

  equal "domainValidation" {
    description = "domainValidation"
    got         = data.aci_rest.infraSetPol.content.domainValidation
    want        = "yes"
  }

  equal "enforceSubnetCheck" {
    description = "enforceSubnetCheck"
    got         = data.aci_rest.infraSetPol.content.enforceSubnetCheck
    want        = "yes"
  }

  equal "opflexpAuthenticateClients" {
    description = "opflexpAuthenticateClients"
    got         = data.aci_rest.infraSetPol.content.opflexpAuthenticateClients
    want        = "no"
  }

  equal "unicastXrEpLearnDisable" {
    description = "unicastXrEpLearnDisable"
    got         = data.aci_rest.infraSetPol.content.unicastXrEpLearnDisable
    want        = "yes"
  }

  equal "validateOverlappingVlans" {
    description = "validateOverlappingVlans"
    got         = data.aci_rest.infraSetPol.content.validateOverlappingVlans
    want        = "yes"
  }

  equal "enableRemoteLeafDirect" {
    description = "enableRemoteLeafDirect"
    got         = data.aci_rest.infraSetPol.content.enableRemoteLeafDirect
    want        = "no"
  }
}
