# Add a secret to store group details
resource "doppler_secret" "zeus_groups" {
  project    = local.secrets.oci
  config     = "prd"
  name       = "OCI_ZEUS_GROUPS"
  value_type = "json"
  value = jsonencode(
    {
      "${local.values.groups.vcn_admins}" : oci_identity_group.vcn_admins.id
    }
  )
}
