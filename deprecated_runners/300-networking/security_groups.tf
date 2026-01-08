resource "oci_core_security_list" "public_runners" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.runners.id

  display_name = "public-runners-sl"

  ingress_security_rules {

    source      = local.networking.cidr.vcn.runners
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the runners vcn's cidr block."
  }

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "private_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.runners.id

  display_name = "private-mgmt-sl"

  ingress_security_rules {
    # Allows SSH traffic from the internet

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allow SSH traffic from the Internet."
  }

  egress_security_rules {

    destination      = local.networking.cidr.vcn.runners
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allows all outbound traffic to the VCN CIDR."

  }

  freeform_tags = local.tags.defaults
}
