# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

# Get ths private ips for web computes
data "oci_core_private_ips" "github_runner" {
  ip_address = local.networking.ip_address.github_runner
  subnet_id  = oci_core_subnet.public_runners.id

  depends_on = [
    oci_core_subnet.public_runners
  ]
}
