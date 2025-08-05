# Create a virtual cloud network for Mgmt
resource "oci_core_vcn" "mgmt" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.mgmt
  ]

  display_name   = "mgmt"
  dns_label      = "mgmt"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}
