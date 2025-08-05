resource "oci_core_security_list" "private_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

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

    destination      = local.networking.cidr.vcn.mgmt
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allows all outbound traffic to the VCN CIDR."

  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "private_k8" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "private-k8-sl"

  ingress_security_rules {

    # Alows all traffic from the VCN CIDR

    source      = local.networking.cidr.vcn.mgmt
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the VCN CIDR"
  }

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "public_k8" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.mgmt.id

  display_name = "public-k8-sl"

  ingress_security_rules {
    # Allows K8 traffic from the internet

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    # Allows HTTPS traffic from the internet

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    # Allows HTTP traffic from the internet

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    # Allows port 8080 traffic from the internet

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 8080
      max = 8080
    }
  }

  ingress_security_rules {

    # Alows all traffic from the VCN CIDR

    source      = local.networking.cidr.vcn.mgmt
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the VCN CIDR"
  }

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  freeform_tags = local.tags.defaults
}
