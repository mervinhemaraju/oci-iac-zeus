resource "oci_identity_policy" "vnpa" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators group to manage VNPA service in this tenancy"
  name           = "administrators-vnpa"
  statements = [
    "allow group ${local.values.groups.administrators} to inspect compartments in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow group ${local.values.groups.administrators} to read instances in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow group ${local.values.groups.administrators} to read virtual-network-family in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow group ${local.values.groups.administrators} to read load-balancers in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow group ${local.values.groups.administrators} to read network-security-group in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow group ${local.values.groups.administrators} to manage vn-path-analyzer-test in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
