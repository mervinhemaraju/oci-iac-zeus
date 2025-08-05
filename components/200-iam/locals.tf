
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-zeus",
      "Environment" = "Production"
      "Component"   = "200-iam"
    }
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_ROOT_ID
    }

    groups = {
      administrators = "Administrators"

      dynamic = {
        instance_principal = "instance-principal-group"
      }
    }
  }

}
