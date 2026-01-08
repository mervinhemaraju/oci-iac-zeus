# The virtual cloud network for Prod and its attachments
resource "oci_core_vcn" "prod" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.prod
  ]

  display_name   = "prod"
  dns_label      = "prod"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}

# > The DRG attachment
resource "oci_core_drg_attachment" "prod" {

  drg_id = oci_core_drg.prod.id

  display_name = "prod-drg-attachment"

  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.prod.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}
