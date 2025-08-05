
# This is the policy that allows an instance
# to call the OCI api without managed credentials

resource "oci_identity_policy" "instance_principal" {

  compartment_id = local.values.compartments.root
  description    = "Allow instances to manage resources."
  name           = "instance-principal-policy"
  statements = [
    "allow dynamic-group ${local.values.groups.dynamic.instance_principal} to manage all-resources in tenancy",
    "allow dynamic-group ${local.values.groups.dynamic.instance_principal} to manage object-family in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
