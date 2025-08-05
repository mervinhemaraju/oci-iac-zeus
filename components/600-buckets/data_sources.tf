# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

data "oci_objectstorage_namespace" "this" {
  compartment_id = local.values.compartments.production
}
