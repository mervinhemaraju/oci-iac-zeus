# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

data "oci_core_vcns" "prod" {
  compartment_id = local.values.compartments.production

  display_name = "prod"
}

data "oci_core_subnets" "public_k8" {
  compartment_id = local.values.compartments.production
  display_name   = "public-k8"
  vcn_id         = data.oci_core_vcns.prod.virtual_networks[0].id
}

data "oci_core_subnets" "private_k8_api" {
  compartment_id = local.values.compartments.production
  display_name   = "private-k8-api"
  vcn_id         = data.oci_core_vcns.prod.virtual_networks[0].id
}

data "oci_core_subnets" "private_k8" {
  compartment_id = local.values.compartments.production
  display_name   = "private-k8"
  vcn_id         = data.oci_core_vcns.prod.virtual_networks[0].id
}

data "oci_core_subnets" "private_mgmt" {
  compartment_id = local.values.compartments.production
  display_name   = "private-mgmt"
  vcn_id         = data.oci_core_vcns.prod.virtual_networks[0].id
}

data "oci_containerengine_node_pool_option" "arm_oke_ol" {
  compartment_id = local.values.compartments.production

  node_pool_option_id = "all"

  # Filter for specific requirements
  node_pool_k8s_version = "v1.34.1"
  node_pool_os_arch     = "AARCH64"
  node_pool_os_type     = "OL8"
}
