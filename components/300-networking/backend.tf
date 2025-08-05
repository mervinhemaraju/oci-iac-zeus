terraform {
  # Backend configuration
  backend "s3" {
    region = var.bucket_region
    key    = "${var.bucket_key_prefix_iac}/networking/state.tf"
    bucket = var.bucket_name
  }
}
