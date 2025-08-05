# Create a main Internet gateway for Mgmt
resource "oci_core_internet_gateway" "mgmt" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  enabled      = true
  display_name = "mgmt-ig"

  freeform_tags = local.tags.defaults
}

# Create a main NAT gateway for Mgmt
resource "oci_core_nat_gateway" "mgmt" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name  = "mgmt-ng"
  freeform_tags = local.tags.defaults
}
