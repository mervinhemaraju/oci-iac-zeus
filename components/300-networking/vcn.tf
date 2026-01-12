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

# Attach ZEUS VCN to ZEUS's DRG (ONE VCN → ONE DRG)
resource "oci_core_drg_attachment" "prod_vcn" {
  drg_id        = oci_core_drg.prod.id
  display_name  = "prod-vcn-drg-attachment"
  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.prod.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}

# Connect ZEUS DRG to GAIA DRG (DRG-to-DRG attachment, same region)
resource "oci_core_drg_attachment" "gaia_drg" {
  drg_id        = oci_core_drg.prod.id
  display_name  = "gaia-drg-attachment"
  freeform_tags = local.tags.defaults

  network_details {
    id   = local.networking.gateways.gaia_database_drg
    type = "REMOTE_PEERING_CONNECTION" # Even though same region, this connects DRGs
  }
}

# # > Attachment to the Database DRG in oci gaia account
# resource "oci_core_drg_attachment" "database_gaia" {

#   drg_id = local.networking.gateways.gaia_database_drg

#   display_name = "database-gaia-drg-attachment"

#   freeform_tags = local.tags.defaults

#   network_details {
#     id             = oci_core_vcn.prod.id
#     type           = "VCN"
#     vcn_route_type = "SUBNET_CIDRS"
#   }
# }

# # > Attachment to the Database DRG in oci poseidon account
# resource "oci_core_drg_attachment" "poseidon_mgmt" {

#   drg_id = oci_core_drg.prod.id

#   display_name = "poseidon-mgmt-drg-attachment"

#   freeform_tags = local.tags.defaults

#   network_details {
#     id             = oci_core_vcn.prod.id
#     type           = "VCN"
#     vcn_route_type = "SUBNET_CIDRS"
#   }
# }
