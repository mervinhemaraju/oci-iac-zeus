
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

  secrets = {
    oci = "cloud-oci-creds"
  }

  networking = {

    gateways = {
      gaia_database_drg = jsondecode(data.doppler_secrets.oci_creds.map.OCI_GAIA_CONNECTIONS)["drg"]["id"]
      gaia_lpg          = jsondecode(data.doppler_secrets.oci_creds.map.OCI_GAIA_CONNECTIONS)["lpg"]["zeus_prod_id"]
      rpc_id_poseidon   = jsondecode(data.doppler_secrets.oci_creds.map.OCI_POSEIDON_CONNECTIONS)["rpc"]["zeus_prod_id"]
    }

    cidr = {
      vcn = {
        prod = "10.17.0.0/16"
      }
      subnets = {
        public_k8               = "10.17.10.0/24"
        private_mgmt            = "10.17.20.0/24"
        private_k8_api          = "10.17.30.0/28"
        private_k8              = "10.17.31.0/24"
        private_database_gaia   = "10.18.20.0/24" # (This is found in the GAIA account)
        private_k8_poseidon     = "10.15.31.0/24" # (This is found in the POSEIDON account)
        private_k8_api_poseidon = "10.15.30.0/28" # (This is found in the POSEIDON account)
      }
    }
  }
}
