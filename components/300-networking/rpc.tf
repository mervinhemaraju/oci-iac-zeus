# Create a remote peering connection for POSEIDON account
resource "oci_core_remote_peering_connection" "poseidon_mgmt" {
  compartment_id = local.values.compartments.production
  drg_id         = oci_core_drg.prod.id

  display_name     = "poseidon-mgmt-rpc"
  peer_id          = local.networking.gateways.rpc_id_poseidon # Acceptor Poseidon rpc id
  peer_region_name = "uk-london-1"                             # Acceptor Poseidon region

  freeform_tags = local.tags.defaults
}
