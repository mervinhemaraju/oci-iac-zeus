# Create a main Internet gateway for Runners
resource "oci_core_internet_gateway" "runners" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.runners.id

  enabled      = true
  display_name = "runners-ig"

  freeform_tags = local.tags.defaults
}
