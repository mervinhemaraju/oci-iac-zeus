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

# > Attachment to the Database DRG in oci gaia account
resource "oci_core_drg_attachment" "database_gaia" {

  drg_id = local.networking.gateways.gaia_database_drg

  display_name = "database-gaia-drg-attachment"

  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.prod.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}
