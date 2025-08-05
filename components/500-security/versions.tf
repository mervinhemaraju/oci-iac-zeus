

# The Terraform Module
terraform {

  # The required tf version
  required_version = "1.8.7"

  # Required providers
  required_providers {

    # Doppler provider
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.7.0"
    }

    # OCI provider
    oci = {
      source  = "oracle/oci"
      version = "6.25.0"
    }

    # AWS provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}
