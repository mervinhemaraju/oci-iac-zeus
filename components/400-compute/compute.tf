

# Create a compute instance for github runner
resource "oci_core_instance" "github_runner" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = "github-runner"

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 24
    ocpus         = 4
    vcpus         = 4
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.public_runners.subnets[0].id
    assign_public_ip       = true
    private_ip             = local.networking.ip_address.github_runner
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "200"
    boot_volume_vpus_per_gb = 120
  }

  agent_config {
    dynamic "plugins_config" {
      for_each = local.values.compute.plugins_config
      content {
        desired_state = plugins_config.value.desired_state
        name          = plugins_config.value.name
      }
    }
  }

  freeform_tags = local.tags.defaults

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC

    # User data from YAML template file
    user_data = base64encode(templatefile("${path.module}/templates/cloud_init.yml", {
      authorized_ssh_key     = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC
      github_pat             = data.doppler_secrets.apps_creds.map.GH_TERRAFORM_TOKEN
      oci_fingerprint        = data.doppler_secrets.oci_creds.map.OCI_API_FINGERPRINT
      oci_private_key_base64 = base64encode(data.doppler_secrets.oci_creds.map.OCI_API_KEY_PRIVATE)

      oci_user_ocid_helios    = data.doppler_secrets.oci_creds.map.OCI_HELIOS_USER_OCID
      oci_tenancy_ocid_helios = data.doppler_secrets.oci_creds.map.OCI_HELIOS_TENANCY_OCID
      oci_prod_cid_helios     = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID

      oci_user_ocid_poseidon    = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_USER_OCID
      oci_tenancy_ocid_poseidon = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_TENANCY_OCID
      oci_prod_cid_poseidon     = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_COMPARTMENT_PRODUCTION_ID

      oci_user_ocid_gaia    = data.doppler_secrets.oci_creds.map.OCI_GAIA_USER_OCID
      oci_tenancy_ocid_gaia = data.doppler_secrets.oci_creds.map.OCI_GAIA_TENANCY_OCID
      oci_prod_cid_gaia     = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID

      oci_user_ocid_zeus    = data.doppler_secrets.oci_creds.map.OCI_ZEUS_USER_OCID
      oci_tenancy_ocid_zeus = data.doppler_secrets.oci_creds.map.OCI_ZEUS_TENANCY_OCID
      oci_prod_cid_zeus     = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_PRODUCTION_ID
    }))
  }
}
