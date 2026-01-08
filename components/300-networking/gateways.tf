# Create a main Internet gateway for Prod
resource "oci_core_internet_gateway" "prod" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.prod.id

  enabled      = true
  display_name = "prod-ig"

  freeform_tags = local.tags.defaults
}

# Create a main NAT gateway for Prod
resource "oci_core_nat_gateway" "prod" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.prod.id

  display_name  = "prod-ng"
  freeform_tags = local.tags.defaults
}

# Create a Dynamic Routing Gateway for VCN peering
resource "oci_core_drg" "prod" {
  compartment_id = local.values.compartments.production

  display_name = "prod-drg"

  freeform_tags = local.tags.defaults
}
