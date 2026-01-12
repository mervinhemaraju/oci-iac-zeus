# Add a secret to store connection details
resource "doppler_secret" "prod_connection_details" {
  project    = local.secrets.oci
  config     = "prd"
  name       = "OCI_ZEUS_CONNECTIONS"
  value_type = "json"
  value = jsonencode(
    {
      "drg" : {
        "id" : oci_core_drg.prod.id
      }
    }
  )
}
