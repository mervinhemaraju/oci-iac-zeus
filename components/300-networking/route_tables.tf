# Route Tables

resource "oci_core_route_table" "public_runners" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.runners.id

  display_name = "route-table-public-runners"

  # Route to the Internet gateway
  route_rules {

    network_entity_id = oci_core_internet_gateway.runners.id

    description      = "Route to the Internet Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

