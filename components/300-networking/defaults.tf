# The default resources that comes with a VCN
resource "oci_core_default_security_list" "prod" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.prod.default_security_list_id
}

resource "oci_core_default_route_table" "prod" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.prod.default_route_table_id
}
