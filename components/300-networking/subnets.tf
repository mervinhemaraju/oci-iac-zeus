

# Create a public subnet for the kubernetes cluster
# resource "oci_core_subnet" "public_k8" {

#   compartment_id = local.values.compartments.production

#   cidr_block = local.networking.cidr.subnets.public_k8
#   vcn_id     = oci_core_vcn.mgmt.id

#   display_name               = "public-k8"
#   dns_label                  = "publick8"
#   prohibit_public_ip_on_vnic = false
#   security_list_ids          = [oci_core_security_list.public_k8.id]

#   route_table_id = oci_core_route_table.public_k8.id

#   freeform_tags = local.tags.defaults

#   depends_on = [
#     oci_core_vcn.mgmt
#   ]
# }

# Create a private subnet for the kubernetes cluster
resource "oci_core_subnet" "private_k8" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_k8
  vcn_id     = oci_core_vcn.prod.id

  display_name               = "private-k8"
  dns_label                  = "privatek8"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_k8.id]

  route_table_id = oci_core_route_table.private_k8.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.prod
  ]
}

# Create a private subnet for the mgmt resources
resource "oci_core_subnet" "private_mgmt" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_mgmt
  vcn_id     = oci_core_vcn.prod.id

  display_name               = "private-mgmt"
  dns_label                  = "privatemgmt"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_mgmt.id]

  route_table_id = oci_core_route_table.private_mgmt.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.prod
  ]
}

