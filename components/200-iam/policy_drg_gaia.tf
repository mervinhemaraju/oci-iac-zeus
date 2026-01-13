
# Create a policy for VCN management as a acceptor
resource "oci_identity_policy" "gaia_database_drg_statements" {

  compartment_id = local.values.compartments.root
  name           = "gaia-database-drg-statements"
  description    = "Allows oci gaia (requestor) to manage VCN, RPC and DRG attachments in this tenancy."

  statements = [
    # Definition - MUST be first
    "define group ${oci_identity_group.vcn_admins.name} as ${oci_identity_group.vcn_admins.id}",
    "define group ${local.values.groups.gaia_groups.drg_admins.name} as ${local.values.groups.gaia_groups.drg_admins.id}",
    "define tenancy gaiaTenancy as ${local.values.compartments.root_gaia}",

    # Allow (local permissions in Zeus)
    "allow group ${oci_identity_group.vcn_admins.name} to manage local-peering-gateways in tenancy",
    "allow group ${oci_identity_group.vcn_admins.name} to manage local-peering-from in tenancy",

    # Endorse (Zeus endorsing its groups to do things in Gaia)
    "endorse group ${local.values.groups.gaia_groups.drg_admins.name} to manage virtual-network-family in tenancy gaiaTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage virtual-network-family in tenancy gaiaTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage drg in tenancy gaiaTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage local-peering-to in tenancy gaiaTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to associate local-peering-gateways in tenancy with local-peering-gateways in tenancy gaiaTenancy",

    # Admit (allowing Gaia's groups to do things in Zeus)
    "admit group ${local.values.groups.gaia_groups.drg_admins.name} of tenancy gaiaTenancy to manage drg-attachment in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
