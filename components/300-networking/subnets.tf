

# Create a public subnet for the runners instance
resource "oci_core_subnet" "public_runners" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.public_runners
  vcn_id     = oci_core_vcn.runners.id

  display_name               = "public-runners"
  dns_label                  = "publicrunners"
  prohibit_public_ip_on_vnic = false
  security_list_ids          = [oci_core_security_list.public_runners.id]

  route_table_id = oci_core_route_table.public_runners.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.runners
  ]
}
