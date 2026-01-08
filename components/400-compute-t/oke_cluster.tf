resource "oci_containerengine_cluster" "apps" {
  #Required
  compartment_id     = local.values.compartments.production
  kubernetes_version = "v1.33.1"
  name               = "applications"
  type               = "BASIC_CLUSTER"
  vcn_id             = data.oci_core_vcns.mgmt.virtual_networks[0].id

  # kms_key_id = oci_kms_key.test_key.id
  # ip_families = var.cluster_options_ip_families

  cluster_pod_network_options {
    cni_type = "OCI_VCN_IP_NATIVE"
  }

  endpoint_config {
    is_public_ip_enabled = true
    # nsg_ids              = var.cluster_endpoint_config_nsg_ids
    subnet_id = data.oci_core_subnets.public_k8.subnets[0].id
  }


  options {

    service_lb_subnet_ids = data.oci_core_subnets.public_k8.subnets[*].id

    add_ons {
      is_kubernetes_dashboard_enabled = true
      is_tiller_enabled               = false
    }

    admission_controller_options {
      is_pod_security_policy_enabled = false
    }

    # kubernetes_network_config {

    #   #Optional
    #   pods_cidr     = "10.16.100.0/24"
    #   services_cidr = "10.16.101.0/24"
    # }

    # open_id_connect_token_authentication_config {
    #   #Required
    #   is_open_id_connect_auth_enabled = var.cluster_options_open_id_connect_token_authentication_config_is_open_id_connect_auth_enabled

    #   #Optional
    #   ca_certificate     = var.cluster_options_open_id_connect_token_authentication_config_ca_certificate
    #   client_id          = oci_containerengine_client.test_client.id
    #   configuration_file = var.cluster_options_open_id_connect_token_authentication_config_configuration_file
    #   groups_claim       = var.cluster_options_open_id_connect_token_authentication_config_groups_claim
    #   groups_prefix      = var.cluster_options_open_id_connect_token_authentication_config_groups_prefix
    #   issuer_url         = var.cluster_options_open_id_connect_token_authentication_config_issuer_url
    #   required_claims {

    #     #Optional
    #     key   = var.cluster_options_open_id_connect_token_authentication_config_required_claims_key
    #     value = var.cluster_options_open_id_connect_token_authentication_config_required_claims_value
    #   }
    #   signing_algorithms = var.cluster_options_open_id_connect_token_authentication_config_signing_algorithms
    #   username_claim     = var.cluster_options_open_id_connect_token_authentication_config_username_claim
    #   username_prefix    = var.cluster_options_open_id_connect_token_authentication_config_username_prefix
    # }

    # open_id_connect_discovery {

    #   #Optional
    #   is_open_id_connect_discovery_enabled = var.cluster_options_open_id_connect_discovery_is_open_id_connect_discovery_enabled
    # }
    persistent_volume_config {
      freeform_tags = local.tags.defaults
    }
    service_lb_config {
      freeform_tags = local.tags.defaults
    }
  }


  freeform_tags = local.tags.defaults

}
