
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-poseidon",
      "Environment" = "Production"
      "Component"   = "400-compute"
    }
  }

  values = {

    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_COMPARTMENT_PRODUCTION_ID
    }


    bastions = {
      "private-jump-01" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
      "private-jump-02" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
    }

    compute = {

      shape          = "VM.Standard.A1.Flex"
      image_oke_node = "ocid1.image.oc1.uk-london-1.aaaaaaaa656st3mmhvhimtpe3n6xehhqc3a24tmwm3vcuuquopcjino3nnxq"

      plugins_config = [
        {
          name          = "Bastion"
          desired_state = "ENABLED"
        },
        {
          name          = "OS Management Service Agent"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Run Command"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Monitoring"
          desired_state = "ENABLED"
        }
      ]
    }
  }

}
