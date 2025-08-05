# Create a virtual cloud network for Runners
resource "oci_core_vcn" "runners" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.runners
  ]

  display_name   = "runners"
  dns_label      = "runners"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}
