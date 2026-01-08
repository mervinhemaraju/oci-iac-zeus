# Route Tables
# resource "oci_core_route_table" "public_k8" {

#   compartment_id = local.values.compartments.production
#   vcn_id         = oci_core_vcn.mgmt.id

#   display_name = "route-table-public-k8"

#   # Route to the Internet gateway
#   route_rules {

#     network_entity_id = oci_core_internet_gateway.mgmt.id

#     description      = "Route to the Internet Gateway (Internet Access)"
#     destination      = "0.0.0.0/0"
#     destination_type = "CIDR_BLOCK"
#   }

#   freeform_tags = local.tags.defaults
# }

resource "oci_core_route_table" "private_k8" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.prod.id

  display_name = "route-table-private-k8"

  # Route to the NAT gateway
  route_rules {

    network_entity_id = oci_core_nat_gateway.prod.id

    description      = "Route to the NAT Gateway (Outbound Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  # Route to the DRG gateway for OCI GAIA connection
  route_rules {

    network_entity_id = oci_core_drg.prod.id

    description      = "Route to the GAIA database tenant's VCN (VCN Peering to GAIA Account)"
    destination      = local.networking.cidr.subnets.private_db_gaia
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_mgmt" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.prod.id

  display_name = "route-table-private-mgmt"

  freeform_tags = local.tags.defaults
}
