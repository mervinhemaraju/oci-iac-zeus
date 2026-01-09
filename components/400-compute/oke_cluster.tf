resource "oci_containerengine_cluster" "apps" {

  compartment_id     = local.values.compartments.production
  kubernetes_version = "v1.34.1"
  name               = "applications"
  type               = "BASIC_CLUSTER"
  vcn_id             = data.oci_core_vcns.prod.virtual_networks[0].id

  # kms_key_id = oci_kms_key.test_key.id
  # ip_families = var.cluster_options_ip_families

  cluster_pod_network_options {
    cni_type = "OCI_VCN_IP_NATIVE"
  }

  endpoint_config {
    is_public_ip_enabled = false
    subnet_id            = data.oci_core_subnets.private_k8_api.subnets[0].id
    # nsg_ids              = var.cluster_endpoint_config_nsg_ids
  }

  options {
    service_lb_subnet_ids = data.oci_core_subnets.public_k8.subnets[*].id

    add_ons {
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }

    admission_controller_options {
      is_pod_security_policy_enabled = false
    }

    persistent_volume_config {
      freeform_tags = local.tags.defaults
    }

    service_lb_config {
      freeform_tags = local.tags.defaults
    }
  }

  freeform_tags = local.tags.defaults

}
