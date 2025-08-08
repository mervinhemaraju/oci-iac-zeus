resource "oci_objectstorage_bucket" "binaries" {
  compartment_id = local.values.compartments.production
  name           = "binaries"
  namespace      = data.oci_objectstorage_namespace.this.namespace

  storage_tier = "Standard"
  access_type  = "ObjectReadWithoutList"
  versioning   = "Disabled"

  freeform_tags = local.tags.defaults
}
