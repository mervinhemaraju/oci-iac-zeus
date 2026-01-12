# Create a remote peering connection for ZEUS -> POSEIDON
resource "oci_core_remote_peering_connection" "poseidon_mgmt" {
  compartment_id = local.values.compartments.production
  drg_id         = oci_core_drg.prod.id

  display_name = "rpc-poseidon-mgmt"
  # peer_id          = local.networking.gateways.rpc_id_poseidon # Reference the ZEUS-specific RPC
  peer_region_name = "uk-london-1"

  freeform_tags = local.tags.defaults
}
