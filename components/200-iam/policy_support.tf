resource "oci_identity_policy" "support" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators group to manage tickets in this tenancy"
  name           = "administrators-support"
  statements = [
    "Allow group ${local.values.groups.administrators} to manage tickets in tenancy",
  ]

  freeform_tags = local.tags.defaults
}
