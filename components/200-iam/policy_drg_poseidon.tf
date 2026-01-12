resource "oci_identity_policy" "poseidon_cross_conection_statements" {

  compartment_id = local.values.compartments.root
  name           = "poseidon-cross-connection-statements"
  description    = "Allow the requestor to manage DRG and RPC in this tenancy and POSEIDON tenancy."

  statements = [
    # Definitions
    "define group ${oci_identity_group.drg_admins.name} as ${oci_identity_group.drg_admins.id}",
    "define group ${local.values.groups.poseidon_groups.vcn_admins.name} as ${local.values.groups.poseidon_groups.vcn_admins.id}",
    "define tenancy poseidonTenancy as ${local.values.compartments.root_poseidon}",

    # Allow - ZEUS manages its own resources
    "allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy",
    "allow group ${oci_identity_group.drg_admins.name} to manage drgs in tenancy",
    "allow group ${oci_identity_group.drg_admins.name} to manage remote-peering-from in tenancy",

    # Endorse - ZEUS endorses itself to work with POSEIDON
    "endorse group ${oci_identity_group.drg_admins.name} to manage drg-attachment in tenancy poseidonTenancy",
    "endorse group ${oci_identity_group.drg_admins.name} to manage remote-peering-to in tenancy poseidonTenancy",

    # Admit - Accept POSEIDON group
    "admit group ${local.values.groups.poseidon_groups.vcn_admins.name} of tenancy poseidonTenancy to manage drg in tenancy",
    "admit group ${local.values.groups.poseidon_groups.vcn_admins.name} of tenancy poseidonTenancy to manage virtual-network-family in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
