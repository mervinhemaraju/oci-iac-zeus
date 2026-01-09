# resource "oci_containerengine_node_pool" "apps" {
#   cluster_id         = oci_containerengine_cluster.apps.id
#   compartment_id     = local.values.compartments.production
#   name               = "apps-node-pool"
#   node_shape         = local.values.compute.shape
#   kubernetes_version = "v1.33.1"
#   ssh_public_key     = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_COMPUTE_KEY_PUBLIC
#   #   subnet_ids          = var.node_pool_subnet_ids

#   #   initial_node_labels {

#   #     #Optional
#   #     key   = var.node_pool_initial_node_labels_key
#   #     value = var.node_pool_initial_node_labels_value
#   #   }
#   node_config_details {
#     size = 2
#     placement_configs {
#       availability_domain = data.oci_identity_availability_domain.this.name
#       subnet_id           = data.oci_core_subnets.private_k8.subnets[0].id

#       #   capacity_reservation_id = oci_containerengine_capacity_reservation.test_capacity_reservation.id
#       #   fault_domains           = var.node_pool_node_config_details_placement_configs_fault_domains

#     }

#     node_pool_pod_network_option_details {
#       cni_type = "OCI_VCN_IP_NATIVE"

#       #Optional
#       # max_pods_per_node = var.node_pool_node_config_details_node_pool_pod_network_option_details_max_pods_per_node
#       # pod_nsg_ids       = var.node_pool_node_config_details_node_pool_pod_network_option_details_pod_nsg_ids
#       pod_subnet_ids = data.oci_core_subnets.private_k8.subnets[*].id
#     }

#     freeform_tags = local.tags.defaults
#   }

#   node_eviction_node_pool_settings {
#     eviction_grace_duration              = "PT1H" # 1 hour grace period
#     is_force_delete_after_grace_duration = true
#   }

#   node_pool_cycling_details {
#     is_node_cycling_enabled = true

#     # Maximum surge during cycling - set to 0 to prevent exceeding 2 instances
#     maximum_surge = "0"

#     # Maximum unavailable during cycling - set to 1 to ensure at least 1 instance remains
#     maximum_unavailable = "1"
#   }

#   node_shape_config {
#     memory_in_gbs = 12
#     ocpus         = 2
#   }

#   node_source_details {
#     image_id                = local.values.compute.image_oke_node
#     source_type             = "IMAGE"
#     boot_volume_size_in_gbs = 75
#   }

#   freeform_tags = local.tags.defaults
# }
