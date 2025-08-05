# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

data "oci_core_vcns" "runners" {
  compartment_id = local.values.compartments.production
  display_name   = "runners"
}

data "oci_core_subnets" "public_runners" {
  compartment_id = local.values.compartments.production
  display_name   = "public-runners"
  vcn_id         = data.oci_core_vcns.runners.virtual_networks[0].id
}

data "oci_core_subnets" "private_mgmt" {
  compartment_id = local.values.compartments.production
  display_name   = "private-mgmt"
  vcn_id         = data.oci_core_vcns.runners.virtual_networks[0].id
}
