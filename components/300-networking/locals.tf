
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-zeus",
      "Environment" = "Production"
      "Component"   = "300-networking"
    }
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_ROOT_ID
    }
  }

  networking = {

    cidr = {
      vcn = {
        runners = "10.17.0.0/16"
      }
      subnets = {
        private_mgmt   = "10.17.10.0/24"
        public_runners = "10.17.20.0/24"
      }
    }
  }
}
