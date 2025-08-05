
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-zeus",
      "Environment" = "Production"
      "Component"   = "600-buckets"
    }
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_ROOT_ID
    }
  }

}
