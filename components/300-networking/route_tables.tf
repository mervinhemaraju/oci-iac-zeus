# Route Tables
resource "oci_core_route_table" "public_k8" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.prod.id

  display_name = "route-table-public-k8"

  # Route to the Internet gateway
  route_rules {

    network_entity_id = oci_core_internet_gateway.prod.id

    description      = "Route to the Internet Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

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

  # Route to the DRG database gateway in GAIA for cross connection
  # route_rules {

  #   network_entity_id = local.networking.gateways.gaia_database_drg

  #   description      = "Route to the GAIA Database account tenant's VCN (VCN Peering to GAIA Account)"
  #   destination      = local.networking.cidr.subnets.private_database_gaia
  #   destination_type = "CIDR_BLOCK"
  # }

  # Route to GAIA via LPG (same region) - REPLACE the existing DRG rule for Gaia
  route_rules {
    network_entity_id = oci_core_local_peering_gateway.to_gaia.id # Use LPG, not DRG

    description      = "Route to the GAIA Database account tenant's VCN (Local VCN Peering to GAIA Account)"
    destination      = local.networking.cidr.subnets.private_database_gaia
    destination_type = "CIDR_BLOCK"
  }

  # Route to the DRG gateway for OCI Poseidon connection
  route_rules {

    network_entity_id = oci_core_drg.prod.id

    description      = "Route to the Poseidon K8 tenant's VCN (VCN Peering to POSEIDON Account)"
    destination      = local.networking.cidr.subnets.private_k8_poseidon
    destination_type = "CIDR_BLOCK"
  }

  # Route to the DRG gateway for OCI POSEIDON private k8 api connection
  route_rules {

    network_entity_id = oci_core_drg.prod.id

    description      = "Route to the POSEIDON private k8 api tenant's VCN (VCN Peering to POSEIDON Account)"
    destination      = local.networking.cidr.subnets.private_k8_api_poseidon
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
