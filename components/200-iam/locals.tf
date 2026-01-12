
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

  secrets = {
    oci = "cloud-oci-creds"
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_ZEUS_COMPARTMENT_ROOT_ID

      root_gaia     = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_ROOT_ID
      root_poseidon = data.doppler_secrets.oci_creds.map.OCI_POSEIDON_COMPARTMENT_ROOT_ID
    }

    groups = {
      drg_admins     = "drg-admins"
      vcn_admins     = "vcn-admins"
      administrators = "Administrators"

      gaia_groups = {
        drg_admins = {
          name = "drg-admins"
          id   = jsondecode(data.doppler_secrets.oci_creds.map.OCI_GAIA_GROUPS)["drg-admins"]
        }
      }

      poseidon_groups = {
        vcn_admins = {
          name = "vcn-admins"
          id   = jsondecode(data.doppler_secrets.oci_creds.map.OCI_POSEIDON_GROUPS)["vcn-admins"]
        }
      }

      dynamic = {
        instance_principal = "instance-principal-group"
      }
    }
  }

}
