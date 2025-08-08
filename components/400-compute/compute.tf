

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
      github_org_url      = "https://github.com/plagueworks-org"
      github_runner_token = data.doppler_secrets.apps_creds.map.GH_ORG_PLAGUEWORKS_RUNNER_TOKEN
      runner_name         = "github-runner-${formatdate("YYYYMMDD", timestamp())}"
      runner_labels       = "self-hosted,Linux,X64,oci"
      runner_work_dir     = "_work"
      authorized_ssh_key  = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC
    }))
  }
}

output "cloud_init_raw" {
  description = "Raw cloud-init configuration (before base64 encoding)"
  value = nonsensitive(templatefile("${path.module}/templates/cloud_init.yml", {
    github_org_url      = "https://github.com/plagueworks-org"
    github_runner_token = data.doppler_secrets.apps_creds.map.GH_ORG_PLAGUEWORKS_RUNNER_TOKEN
    runner_name         = "github-runner-${formatdate("YYYYMMDD", timestamp())}"
    runner_labels       = "self-hosted,Linux,X64,oci"
    runner_work_dir     = "_work"
    authorized_ssh_key  = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC
  }))
}
