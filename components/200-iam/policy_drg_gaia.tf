
# Create a policy for VCN management as a acceptor
resource "oci_identity_policy" "gaia_database_drg_statements" {

  compartment_id = local.values.compartments.root
  name           = "gaia-database-drg-statements"
  description    = "Allows oci gaia (requestor) to manage VCN, RPC and DRG attachments in this tenancy."

  statements = [
    # Definition
    "define group ${oci_identity_group.vcn_admins.name} as ${oci_identity_group.vcn_admins.id}",
    "define group ${local.values.groups.gaia_groups.drg_admins.name} as ${local.values.groups.gaia_groups.drg_admins.id}",
    "define tenancy gaiaTenancy as ${local.values.compartments.root_gaia}",

    # Endorse
    "endorse group ${local.values.groups.gaia_groups.drg_admins.name} to manage virtual-network-family in tenancy gaiaTenancy",
    "endorse group ${oci_identity_group.vcn_admins.name} to manage virtual-network-family in tenancy gaiaTenancy",
    # Admit
    "admit group ${local.values.groups.gaia_groups.drg_admins.name} of tenancy gaiaTenancy to manage drg-attachment in tenancy",
    # Endorse
    "endorse group ${oci_identity_group.vcn_admins.name} to manage drg in tenancy gaiaTenancy",
  ]

  freeform_tags = local.tags.defaults
}
